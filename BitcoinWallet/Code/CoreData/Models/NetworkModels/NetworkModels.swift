//
//  NetworkModels.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 03.11.2022.
//

import Foundation

//// MARK: - ExchangeResults
//struct ExchangeResults: Codable {
//    let time: Time
//    let disclaimer, chartName: String
//    let exchange: Exchange
//
//    enum CodingKeys: String, CodingKey {
//        case time
//        case disclaimer, chartName
//        case exchange = "bpi"
//    }
//}
//
//// MARK: - Bpi
//struct Exchange: Codable {
//    let usd, gbp, eur: Eur
//
//    enum CodingKeys: String, CodingKey {
//        case usd = "USD"
//        case gbp = "GBP"
//        case eur = "EUR"
//    }
//}
//
//// MARK: - Eur
//struct Eur: Codable {
//    let code, symbol, rate, eurDescription: String
//    let rateFloat: Double
//
//    enum CodingKeys: String, CodingKey {
//        case code, symbol, rate
//        case eurDescription = "description"
//        case rateFloat = "rate_float"
//    }
//}
//
//// MARK: - Time
//struct Time: Codable {
//    let updated: String
//    let updatedISO: Date
//    let updateduk: String
//}

// MARK: - Btc
struct Btc: Codable {
    let time: Time
    let disclaimer, chartName: String
    let bpi: Bpi
}

// MARK: - Bpi
struct Bpi: Codable {
    let usd, gbp, eur: Eur

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

// MARK: - Eur
struct Eur: Codable {
    let code, symbol, rate, eurDescription: String
    let rateFloat: Double

    enum CodingKeys: String, CodingKey {
        case code, symbol, rate
        case eurDescription = "description"
        case rateFloat = "rate_float"
    }
}

// MARK: - Time
struct Time: Codable {
    let updated: String
    let updatedISO: String
    let updateduk: String
}
