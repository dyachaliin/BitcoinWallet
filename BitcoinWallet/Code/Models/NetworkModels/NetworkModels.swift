//
//  NetworkModels.swift
//  BitcoinWallet
//
//  Created by Alina Diachenko on 03.11.2022.
//

import Foundation

// MARK: - ExchangeResult
struct ExchangeResult: Codable {
    let time: Time
    let disclaimer, chartName: String
    let currency: Currency
    
    enum CodingKeys: String, CodingKey {
        case time
        case disclaimer, chartName
        case currency = "bpi"
    }
}

// MARK: - Currency
struct Currency: Codable {
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
