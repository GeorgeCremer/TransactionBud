//
//  NetworkManager.swift
//  TransactionBud
//
//  Created by George Cremer on 17/04/2021.
//

import UIKit

protocol NetworkManagerProtocol {
    func retrieveTransactions(completed: @escaping (Result<[BudTransactionModel], ErrorsTB>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    private var urlSession: URLSession!
    private let imageCache = NSCache<NSString, UIImage>()

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func retrieveTransactions(completed: @escaping (Result<[BudTransactionModel], ErrorsTB>) -> Void) {
        guard let url = URL(string: "http://www.mocky.io/v2/5b36325b340000f60cf88903") else {
            completed(.failure(.unableToCompleteNetworkRequestURLError))
            return
        }

        let task = urlSession.dataTask(with: url) { data, response, error in

            if let _ = error { completed(.failure(.unableToCompleteNetworkRequest)) }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                let json = try decoder.decode(BudAPITransactionModel.self, from: data)

                guard let dataArray = json.data else {
                    completed(.failure(.invalidData))
                    return
                }

                print(dataArray)
                var transactions: [BudTransactionModel] = []

                for result in dataArray {
                    guard let id = result.id else { return }
                    guard let date = result.date else { return }
                    guard let description = result.description else { return }
                    guard let category = result.category else { return }
                    guard let currency = result.currency else { return }
                    guard let currencyISO = result.amount?.currencyIso else { return }
                    guard let value = result.amount?.value else { return }
                    guard let productTitle = result.product?.title else { return }
                    guard let productID = result.product?.id else { return }
                    guard let productIcon = result.product?.icon else { return }

                    guard let currencySymbol = currencyISO.getCurrencySymbol() else { return }

                    transactions.append(BudTransactionModel(id: id, date: date, description: description, category: category, currency: currency, currencyISO: currencyISO, productTitle: productTitle, productIcon: productIcon, value: "\(currencySymbol)\(value.description)", productID: productID))
                }

                completed(.success(transactions))

            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
