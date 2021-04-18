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
}
