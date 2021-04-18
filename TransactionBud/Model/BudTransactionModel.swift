//
//  BudTransactionModel.swift
//  TransactionBud
//
//  Created by George Cremer on 17/04/2021.
//

import Foundation

struct BudTransactionModel: Codable {
    var id, date, description, category, currency, currencyISO, productTitle, productIcon: String
    var value: String
    var productID: Int
}
