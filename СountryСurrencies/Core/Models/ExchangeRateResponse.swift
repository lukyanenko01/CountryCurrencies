//
//  ExchangeRateResponse.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import Foundation

struct ExchangeRateResponse: Codable {
    let baseCode: String
    let conversionRates: [String: Double]

    enum CodingKeys: String, CodingKey {
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}


