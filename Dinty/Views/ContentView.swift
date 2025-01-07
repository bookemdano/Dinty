//
//  ContentView.swift
//  MacLab
//
//  Created by Daniel Francis on 1/3/25.
//

import SwiftUI


struct ContentView: View {
    let _iop = IOPAws()
    @State private var _accounts: [Account] = []
    @State private var _show: Bool = false
    @State private var _groups: [String: Bool] = ["Bank":true, "Card":true, "LongInvestment":false, "ShortInvestment":false, "Cash":false, "Other":false]
    var body: some View {
        NavigationView{
            VStack{
                HStack(){
                    ForEach(Array(_groups.keys.sorted()), id: \.self) { key in
                        Button(action: {
                            OnOff(group: key)
                        }) {
                            Text(key)
                                .bold(_groups[key]!)
                        }
                    }
                }
                List(_accounts){ account in
                    HStack{
                        NavigationLink(destination: AccountView(account: account)){
                            Text(account.Info.ShortName).font(.headline)
                        }
                        Spacer()
                        Text(account.PaymentDateString())
                        Text(account.CalcedBalance.ToString())
                    }
                }
            }
            .navigationTitle(Text("Dan Accounts"))
        }
        
        .refreshable {
            Refresh()
        }
        .onAppear {
            Refresh()
       }
    }
    func OnOff(group: String){
        _groups[group] = !(_groups[group] ?? false)
        Refresh()
    }
    func Refresh(){
        Task{
            let content = await _iop.Read(dir: "Data", file: "accountsDan.json")
            
            let jsonString = content
            if let jsonData = jsonString.data(using: .utf8) {
                do {
                    var accountList = try JSONDecoder().decode(Accounts.self, from: jsonData)
                    accountList.filterByGroups(groups: _groups)
                    accountList.getTotal()
                    _accounts = accountList.Account2s.sorted(by: { $0.CalcedBalance.Amount < $1.CalcedBalance.Amount })
                    print("Name: \(_accounts[0].Info.Name)")
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            }
        }
    }


}

#Preview {
    ContentView()
}

