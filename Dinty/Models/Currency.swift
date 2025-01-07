//
//  Currency.swift
//  Dinty
//
//  Created by Daniel Francis on 1/7/25.
//

import Foundation

struct Currency: Codable {
    var Amount: Double
    init(amount: Double) {
        Amount = amount
    }
    
    public func ToString() -> String {
        let amt = abs(Amount)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        if let formattedNumber = formatter.string(from: NSNumber(value: amt)) {
            if (Amount < 0){
                return "(" + formattedNumber + ")"
            }
            else{
                return formattedNumber
            }
        }
        return String(Amount)

    }
}
