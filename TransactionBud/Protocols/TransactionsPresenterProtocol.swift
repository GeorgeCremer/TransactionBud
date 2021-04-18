//
//  TransactionsPresenterProtocol.swift
//  TransactionBud
//
//  Created by George Cremer on 17/04/2021.
//

import UIKit

protocol TransactionsPresenterProtocol: AnyObject {
    init(networkManager: NetworkManagerProtocol, networkManagerDelegate: NetworkManagerDelegate, menuDelegate: MenuDelegate)
    func retrieveTransactions()
    func onViewDidLoad()
}
