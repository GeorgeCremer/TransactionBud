//
//  BudTransactionsModel.swift
//  TransactionBud
//
//  Created by George Cremer on 17/04/2021.
//

import Foundation

struct BudAPITransactionModel: Codable {
    var data: [Transaction]?
}

struct Transaction: Codable {
    var id, date, description, category, currency: String?
    var amount: Amount?
    var product: Product?
}

struct Amount: Codable {
    var value: Double?
    var currencyIso: String?
}

struct Product: Codable {
    var id: Int?
    var title, icon: String?
}
