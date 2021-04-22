//
//  MockTransactionsPresenter.swift
//  TransactionBudTests
//
//  Created by George Cremer on 21/04/2021.
//

import Foundation
@testable import TransactionBud


class MockTransactionsPresenter: TransactionsPresenterProtocol {
   
    var didCallRetrieveTransactions = false
    
    required init(networkManager: NetworkManagerProtocol, networkManagerDelegate: NetworkManagerDelegate, menuDelegate: MenuDelegate) {
        //TODO
        
    }
    
    func retrieveTransactions() {
        didCallRetrieveTransactions = true
    }
}
