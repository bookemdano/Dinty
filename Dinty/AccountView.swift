//
//  AccountView.swift
//  MacLab
//
//  Created by Daniel Francis on 1/5/25.
//

import SwiftUICore
import UIKit

struct AccountView: View {
    let account: Account

    var body: some View {
        Text("Details for \(account.AccountUrl)")
            .font(.largeTitle)
            .padding()
    }
    // openBrowser(urlString: account.AccountUrl)
    func openBrowser(urlString: String) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Invalid URL")
        }
    }
}
