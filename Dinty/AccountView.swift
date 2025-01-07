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
            Text(account.CalcedBalance.ToString())
                .font(.largeTitle)
            Text("Statement: \(account.StatementBalance!.ToString()) Due: \(account.PaymentDateString())")
            Button(action: {
                openBrowser(urlString: account.AccountUrl)
            }) {
                Text("url")
                    .foregroundColor(.blue)
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
