//
//  CurrencyModel.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import Foundation

struct CurrencyModel: Identifiable, Codable {
    var id = UUID()
    let countryName: String
    let currencyCode: String
    let currencyName: String
}
