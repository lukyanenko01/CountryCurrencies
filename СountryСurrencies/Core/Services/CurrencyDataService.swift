//
//  CurrencyDataService.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import Foundation

class CurrencyDataService {
    static let shared = CurrencyDataService()
    
    func loadCurrencies() -> [CurrencyModel]? {
        if let url = Bundle.main.url(forResource: "country_currencies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([String: [String: String]].self, from: data)
                
                var currencies: [CurrencyModel] = []
                for (country, info) in jsonData {
                    if let code = info["Currency Code"], let name = info["Currency Name"] {
                        let currency = CurrencyModel(countryName: country, currencyCode: code, currencyName: name)
                        currencies.append(currency)
                    }
                }
                return currencies
                
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
