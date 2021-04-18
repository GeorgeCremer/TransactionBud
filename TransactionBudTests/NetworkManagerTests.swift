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
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = NetworkManager(urlSession: urlSession)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testNetworkManager_WhenGivenSuccessfulResponse_ReturnSuccess() {
        let responseJSONData = BudTransactionApiStub().successfulResponse.data(using: .utf8)

        MockURLProtocol.loadingHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, responseJSONData, nil)
        }

        let myExpectation = expectation(description: "loading")

        sut.retrieveTransactions(completed: { result in
            switch result {
            case let .success(result):
                XCTAssertTrue(result.count == 10, "Expecting 10 transactions from BudTransactionApiStub().successfulResponse.data.")
            case let .failure(error):
                XCTFail("retrieveTransactions() expected a successful result, not error: \(error)")
            }
            myExpectation.fulfill()
        })
        wait(for: [myExpectation], timeout: 4)
    }

    func testNetworkManager_WhenStatusCodeNot200_ReturnError() {
        let responseJSONData = BudTransactionApiStub().successfulResponse.data(using: .utf8)

        MockURLProtocol.loadingHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 100, httpVersion: nil, headerFields: nil)!
            return (response, responseJSONData, nil)
        }

        let myExpectation = expectation(description: "loading")

        sut.retrieveTransactions(completed: { result in
            switch result {
            case .success:
                XCTFail("retrieveTransactions() expected a error - returned successfully")
            case let .failure(error):
                XCTAssertEqual(error, ErrorsTB.invalidResponse, "retrieveTransactions() expected invalidResponse error")
            }

            myExpectation.fulfill()
        })
        wait(for: [myExpectation], timeout: 5)
    }

    func testNetworkManager_WhenInvalidData_ReturnErrorInvalidData() {
        let responseJSONData = BudTransactionApiStub().invalidResponse.data(using: .utf8)

        MockURLProtocol.loadingHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, responseJSONData, nil)
        }

        let myExpectation = expectation(description: "loading")

        sut.retrieveTransactions(completed: { result in
            switch result {
            case .success:
                XCTFail("retrieveTransactions()  expected a error - returned successfully")

            case let .failure(error):
                XCTAssertEqual(error, ErrorsTB.invalidData, "retrieveTransactions() expected invalidData error")
            }

            myExpectation.fulfill()
        })
        wait(for: [myExpectation], timeout: 5)
    }
}
