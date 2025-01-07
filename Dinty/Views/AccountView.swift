//
//  AccountView.swift
//  MacLab
//
//  Created by Daniel Francis on 1/5/25.
//

import SwiftUICore
import UIKit
import SwiftUI

struct AccountView: View {
    let account: Account
    var body: some View {
        VStack
        {
            HStack{
                Text("Bal: \(account.CalcedBalance.ToString())")
                //.font(.largeTitle)
                Button(action: {
                    openBrowser(urlString: account.AccountUrl)
                }) {
                    Text("🌐")
                        .foregroundColor(.blue)
                }
            }
            .navigationTitle(account.Info.ShortName)
            if (account.StatementBalance != nil)
            {
                Text("Statement: \(account.StatementBalance!.ToString()) Due: \(account.PaymentDateString())")
            }
 
            List(account.Transactions.sorted(by: { $0.Timestamp > $1.Timestamp })){ transaction in
                HStack{
                    Text(transaction.TimestampString())
                    Text(transaction.Title)
                    Spacer()
                    Text(transaction.Amount.ToString()).italic(transaction.Pending)
                }
            }
        }
    }
    func openBrowser(urlString: String?) {
        if (urlString == nil){
            return print("No URL");
        }
        else if let url = URL(string: urlString!), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Invalid URL")
        }
    }
}
