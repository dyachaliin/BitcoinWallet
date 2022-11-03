//
//  NetworkManager.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 03.11.2022.
//

import Foundation

enum ObtainResult {
    case success(result: Btc?)
    case failure(error: Error)
}

class NetworkManager {
    private let sessionConfiguration = URLSessionConfiguration.default
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    
    func obtainExchangeResults(completion: @escaping (ObtainResult) -> Void) {
        guard let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else { return }
        
        session.dataTask(with: url) { [weak self] (data, response, error) in
            
            var result: ObtainResult
            
            defer {
                DispatchQueue.main.async {
                    completion(result) 
                }
            }
            
            guard let self = self else {
                result = .success(result: nil)
                return
                
            }
            
            if error == nil, let parseData = data {
                guard let exchange = try? self.decoder.decode(Btc.self, from: parseData) else {
                    result = .success(result: nil)
                    return
                }
                print(exchange.bpi.usd.rateFloat)
                result = .success(result: exchange)
            } else {
                print(error?.localizedDescription)
                result = .failure(error: error!)
            }
            
            
        }.resume()
    }
}
