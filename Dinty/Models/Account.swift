//
//  Accounts.swift
//  MacLab
//
//  Created by Daniel Francis on 1/5/25.
//

import Foundation

struct Accounts: Codable{
    var Account2s: [Account]
    public mutating func getTotal() {
        var calced = 0.0
        var statement = 0.0
        for account in Account2s {
            calced += account.CalcedBalance.Amount
            if (account.StatementBalance != nil){
                statement += account.StatementBalance!.Amount
                
            }
        }
        let accountInfo: AccountInfo = AccountInfo(name: "Total", shortName: "Total", group: "Total")
        let totalAccount: Account = Account(info: accountInfo, calcedBalance: Currency(amount: calced), statementBalance: Currency(amount: statement))
        Account2s.append(totalAccount)
    }
    public mutating func filterByGroups(groups:[String:Bool]){
        groups.forEach { key, value in
            if value == false {
                Account2s.removeAll(where: { $0.Info.Group == key })
            }
        }
    }
}
struct Account: Identifiable, Codable {
    var id = UUID() // Automatically generate a unique identifier

    init(info: AccountInfo, calcedBalance: Currency, statementBalance: Currency){
        Info = info
        CalcedBalance = calcedBalance
        StatementBalance = statementBalance
        AccountUrl = nil
        PaymentDate = nil
    }
    let AccountUrl: String?
    var Info: AccountInfo
    var CalcedBalance: Currency
    var StatementBalance: Currency?
    let PaymentDate: String?
    var Transactions: [Transaction] = []
    func PaymentDateDate() -> Date? {
        if (PaymentDate == nil || PaymentDate!.starts(with: "00")) {
            return nil
        }
        let sub = PaymentDate!.prefix(10)
        let datePart = String(sub)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        if let date = formatter.date(from: datePart) {
            return date
        }
        return nil
    }
    func PaymentDateString() -> String {
        let date = PaymentDateDate()
        if (date == nil) {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"

        return formatter.string(from: date!)
    }
    
    enum CodingKeys: String, CodingKey {
        case AccountUrl
        case Info
        case CalcedBalance
        case StatementBalance
        case PaymentDate
        case Transactions
    }
}
struct AccountInfo: Codable {
    init(name: String, shortName: String, group: String) {
        Name = name
        ShortName = shortName
        Group = group
    }
    var Name: String
    var ShortName: String
    var Group: String
}

