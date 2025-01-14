//
//  Transaction.swift
//  Dinty
//
//  Created by Daniel Francis on 1/7/25.
//

import Foundation

struct Transaction: Identifiable, Codable {
    var id = UUID() // Automatically generate a unique identifier
    let Title: String
    let Timestamp: String
    let Amount: Currency
    let Category: String
    let Asset: String?
    let Status: String
    func IsPending() -> Bool {
        return (Status == "ScheduledAndPending" || Status == "NotScheduledAndPending" || Status == "Pending")
    }
    func IsFuture() -> Bool {
        return Status == "Future"
    }
    func TimestampDate() -> Date {
        let sub = Timestamp.prefix(10)
        let datePart = String(sub)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        if let date = formatter.date(from: datePart) {
            return date
        }
        return Date()
    }
    func TimestampString() -> String {
        let date = TimestampDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yy"

        return formatter.string(from: date)
    }
    enum CodingKeys: String, CodingKey {
        case Title
        case Timestamp
        case Amount
        case Category
        case Asset
        case Status
    }
}
