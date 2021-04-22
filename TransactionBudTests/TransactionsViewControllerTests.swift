//
//  TransactionsViewControllerTests.swift
//  TransactionBudTests
//
//  Created by George Cremer on 18/04/2021.
//

import XCTest

@testable import TransactionBud




class TransactionsViewControllerTests: XCTestCase {
    
    var sut: TransactionsViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "TransactionsViewController") as? TransactionsViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testTransactionsViewController_WhenCreated_IsNavBarUIConfiguredCorrectly() throws {
        sut.configNavBar()
        XCTAssertTrue(sut.navigationItem.title == "Transactions", "navigationItem.title is not set correctly")
        XCTAssertTrue(sut.rightBarButtonItem.title == EditButtonStates.edit.title, "rightBarButtonItem.title is not set correctly")
        XCTAssertTrue(sut.leftBarButtonItem.image == Images.menu, "leftBarButtonItem.image is not set correctly")
    }

    func testTransactionsViewController_WhenCreated_IsNavBarTableViewConfiguredCorrectly() throws {
        sut.configTableView()
        XCTAssertTrue(sut.tableView.separatorStyle == .none, "tableView.separatorStyle is not set to none")
        XCTAssertTrue(sut.tableView.allowsMultipleSelectionDuringEditing, "tableView.allowsMultipleSelectionDuringEditing is not set to true")
    }
    
    func testTransactionsViewController_WhenCreated_RetrievesTransactionOnViewWillAppear() throws {
        // This wasn't included in my initial submission, in fact there was an error in TransactionsViewController which had the transactionsPresenter set to TransactionPresenter() not the protocol, which would've prevented me mocking the presenter - only noticed when reviewing the code so decided to go ahead and write the below test and mock files as demo.
        
        let networkMangerProtocol = MockNetworkManagerProtocol()
        let networkManagerDelegate = MockNetworkManagerDelegate()
        let menuDelegate = MockMenuDelegate()

        let mockTransactionsPresenter = MockTransactionsPresenter(networkManager: networkMangerProtocol, networkManagerDelegate: networkManagerDelegate, menuDelegate: menuDelegate)
        sut.transactionsPresenter = mockTransactionsPresenter
        sut.viewWillAppear(false)
        XCTAssertTrue(mockTransactionsPresenter.didCallRetrieveTransactions, "retrieveTransactions() was not called on the presenter object when TransactionsViewController.viewWillAppear was called")

        
        
    }

}

