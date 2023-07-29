//
//  SelectedCurrencyViewModel.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 29.07.2023.
//

import SwiftUI
import RealmSwift

class SelectedCurrencyViewModel: ObservableObject {
    
    @Published var currencies: [CurrencyModel] = []
    @Published var selectedCurrency: CurrencyModel?
    
    @Published var selectedCurrencyInSettings: CurrencyModel? {
        didSet {
            guard let selectedCurrency = selectedCurrencyInSettings else { return }
            do {
                try saveSelectedCurrency(selectedCurrency)
            } catch {
                print("Failed to save selected currency: \(error)")
            }
        }
    }
    
    let apiService = APIService()
    
    init() {
           self.loadCurrencies()
           
           if let savedCurrency = RealmManager.shared.loadSelectedCurrency() {
               self.selectedCurrencyInSettings = savedCurrency
           }
       }
    func loadCurrencies() {
        self.currencies = CurrencyDataService.shared.loadCurrencies() ?? []
    }
    
    
    private func saveSelectedCurrency(_ currency: CurrencyModel) throws {
        try RealmManager.shared.saveSelectedCurrency(currency)
    }
    
    private func loadSelectedCurrency() -> CurrencyModel? {
        return RealmManager.shared.loadSelectedCurrency()
    }
}
