//
//  MockNetworkManagerProtocol.swift
//  TransactionBudTests
//
//  Created by George Cremer on 21/04/2021.
//

import Foundation
@testable import TransactionBud

class MockNetworkManagerProtocol :NetworkManagerProtocol {
    func retrieveTransactions(completed: @escaping (Result<[BudTransactionModel], ErrorsTB>) -> Void) {
        //TODO
    }
}
