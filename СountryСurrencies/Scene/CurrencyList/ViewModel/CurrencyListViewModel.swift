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
        fetchAllExchangeRates()
    }

    func fetchAllExchangeRates() {
        apiService.fetchExchangeRate(baseCurrency: "UAH") { (response) in
            if let conversionRates = response?.conversionRates {
                DispatchQueue.main.async {
                    self.exchangeRates = conversionRates
                }
            }
        }
    }
}

