//
//  CurrencyData.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import Foundation

struct CurrencyData: Codable {
    let currencyCode: String
    let currencyName: String

    enum CodingKeys: String, CodingKey {
        case currencyCode = "Currency Code"
        case currencyName = "Currency Name"
    }
}

typealias CountryCurrencies = [String: CurrencyData]
