//
//  NetworkManager.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 03.11.2022.
//

import Foundation

enum ObtainResult {
    case success(result: Result?)
    case failure(error: Error)
}

class NetworkManager {
    
    static let urlSession = URLSession(configuration: .default)
    
    static func obtainExchangeResults(completion: @escaping (ObtainResult) -> Void) {
        guard let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else { return }
        
        NetworkManager.urlSession.dataTask(with: url) { (data, response, error) in
            
            var result: ObtainResult
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            if error == nil, let parseData = data {
                guard let exchange = try? JSONDecoder().decode(Result.self, from: parseData) else {
                    result = .success(result: nil)
                    return
                }
                print(exchange.currency.usd.rateFloat)
                result = .success(result: exchange)
            } else {
                print(error?.localizedDescription)
                result = .failure(error: error!)
            }
        }.resume()
    }
}
