//
//  ContentView.swift
//  MacLab
//
//  Created by Daniel Francis on 1/3/25.
//

import SwiftUI


struct ContentView: View {
    let _iop = IOPAws()
    @State private var accounts: [Account] = []
    
    var body: some View {
        NavigationView{
            List(accounts){ account in
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
        .refreshable {
            Refresh()
        }
        .onAppear {
            Refresh()
       }
    }
    func Refresh(){
        Task{
            let content = await _iop.Read(dir: "Data", file: "accountsDan.json")
            
            let jsonString = content
            if let jsonData = jsonString.data(using: .utf8) {
                do {
                    var accountList = try JSONDecoder().decode(Accounts.self, from: jsonData)
                    accountList.getTotal()
                    accounts = accountList.Account2s.sorted(by: { $0.CalcedBalance.Amount < $1.CalcedBalance.Amount })
                    print("Name: \(accounts[0].Info.Name)")
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

