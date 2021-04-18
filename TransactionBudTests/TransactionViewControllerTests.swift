//
//  NetworkManagerTests.swift
//  TransactionBudTests
//
//  Created by George Cremer on 18/04/2021.
//

@testable import TransactionBud
import XCTest

class NetworkManagerTests: XCTestCase {
    var config: URLSessionConfiguration!
    var sut: NetworkManager!

    override func setUpWithError() throws {
        config = URLSessionConfiguration.ephemeral
//        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = NetworkManager()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
