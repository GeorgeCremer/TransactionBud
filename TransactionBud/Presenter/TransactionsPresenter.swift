//
//  TransactionsPresenter.swift
//  TransactionBud
//
//  Created by George Cremer on 17/04/2021.
//

import UIKit

class TransactionsPresenter: TransactionsPresenterProtocol {
    private var menuDelegate: MenuDelegate!
    private var networkManager: NetworkManagerProtocol!
    private weak var networkManagerDelegate: NetworkManagerDelegate?

    required init(networkManager: NetworkManagerProtocol, networkManagerDelegate: NetworkManagerDelegate, menuDelegate: MenuDelegate) {
        self.networkManager = networkManager
        self.networkManagerDelegate = networkManagerDelegate
        self.menuDelegate = menuDelegate
    }

    func retrieveTransactions() {
        networkManager.retrieveTransactions { result in
            switch result {
            case let .success(result):
                self.networkManagerDelegate?.successfullyRetrieved(transactions: result)
            case let .failure(error):
                self.networkManagerDelegate?.errorHandler(error: error)
            }
        }
    }
}
