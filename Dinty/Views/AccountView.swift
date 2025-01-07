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
            Text("Bal: \(account.CalcedBalance.ToString())")
                //.font(.largeTitle)
                .navigationTitle(account.Info.ShortName)
            Text("Statement: \(account.StatementBalance!.ToString()) Due: \(account.PaymentDateString())")
            Button(action: {
                openBrowser(urlString: account.AccountUrl)
            }) {
                Text("url")
                    .foregroundColor(.blue)
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
