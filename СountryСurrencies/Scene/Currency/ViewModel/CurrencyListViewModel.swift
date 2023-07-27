//
//  CurrencyListViewModel.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import SwiftUI

class CurrencyListViewModel: ObservableObject {
    @Published var currencies: [CurrencyModel] = []
    @Published var exchangeRates: [String: Double] = [:]

    let apiService = APIService()

    init() {
        loadCurrencies()
    }

    func loadCurrencies() {
        self.currencies = CurrencyDataService.shared.loadCurrencies() ?? []
        for currency in currencies {
            fetchExchangeRate(for: currency.currencyCode)
        }
    }

    func fetchExchangeRate(for currencyCode: String) {
        apiService.fetchExchangeRate(baseCurrency: currencyCode) { (response) in
            if let rate = response?.conversionRates["UAH"] {
                DispatchQueue.main.async {
                    self.exchangeRates[currencyCode] = rate
                }
            }
        }
    }
}

