//
//  NetworkManager.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 03.11.2022.
//

import Foundation

class NetworkManager {
    
    enum ObtainResult {
        case success(result: ExchangeResult?)
        case failure(error: Error)
    }
    
    enum ResultFetchError: Error {
        case invalidUrl
        case unknown
        case parsingError
    }
    
    static let urlSession = URLSession(configuration: .default)
    
    static func obtainExchangeResults(completion: @escaping (Result<ExchangeResult, Error>) -> Void) throws {
        
        guard let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else {
            throw ResultFetchError.invalidUrl
        }
        
        NetworkManager.urlSession.dataTask(with: url) { (data, response, error) in
            if error == nil, let parseData = data {
                do {
                    let exchange = try JSONDecoder().decode(ExchangeResult.self, from: parseData)
                    DispatchQueue.main.async {
                        completion(.success(exchange))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(ResultFetchError.unknown))
            }
        }.resume()
    }
}
