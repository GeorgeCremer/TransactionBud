//
//  ErrorsTB.swift
//  TransactionBud
//
//  Created by George Cremer on 17/04/2021.
//

import Foundation

enum ErrorsTB: String, Error, CaseIterable {
    case unableToCompleteNetworkRequest = "Unable to complete network request, please check your internet connection."
    case unableToCompleteNetworkRequestURLError = "Unable to complete network request due to an invalid URL."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received form the server was invalid. Please try again."
    case unableToRetrieveUrlPath = "Unable to complete network request due to an invalid URL path."
}
