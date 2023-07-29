//
//  SelectedCurrencyViewModel.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 29.07.2023.
//

import SwiftUI

class SelectedCurrencyViewModel: ObservableObject {
    @Published var selectedCurrency: CurrencyModel?
    @Published var currencies: [CurrencyModel] = []

    
    let apiService = APIService()
    
    init() {
        loadCurrencies()
    }
    
    func loadCurrencies() {
        self.currencies = CurrencyDataService.shared.loadCurrencies() ?? []
    }
}
