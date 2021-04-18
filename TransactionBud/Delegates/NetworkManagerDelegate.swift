//
//  protocol CoffeeLocationNetworkManagerDelegate.swift
//  TransactionBud
//
//  Created by George Cremer on 17/04/2021.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func successfullyRetrieved(transactions: [BudTransactionModel])
    func errorHandler(error: ErrorsTB)
}
