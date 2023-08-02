//
//  SettingsCurrencyViewModel.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 02.08.2023.
//

import SwiftUI
import RealmSwift


class SettingsCurrencyViewModel: CurrencyViewModelProtocol {
    var selectedCurrency: CurrencyModel?
    var isAddCurrencyViewSource = false
    @Published var currencies: [CurrencyModel] = []
    
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
    
    let apiService = APIManager()
    
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
    
}
