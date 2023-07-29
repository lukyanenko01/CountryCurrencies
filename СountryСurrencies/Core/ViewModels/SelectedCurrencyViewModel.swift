//
//  SelectedCurrencyViewModel.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 29.07.2023.
//

import SwiftUI
import RealmSwift

class SelectedCurrencyViewModel: ObservableObject {
    private var realm: Realm?
    
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
        do {
            self.realm = try Realm()
            self.loadCurrencies()
            
            if let savedCurrency = loadSelectedCurrency() {
                self.selectedCurrencyInSettings = savedCurrency
            }
        } catch {
            print("Failed to initialize Realm: \(error)")
        }
    }
    
    func loadCurrencies() {
        self.currencies = CurrencyDataService.shared.loadCurrencies() ?? []
    }
    
    private func saveSelectedCurrency(_ currency: CurrencyModel) throws {
        guard let realm = self.realm else {
            print("Realm is not initialized.")
            return
        }
        
        let realmCurrency = SelectedCurrency()
        realmCurrency.id = currency.id.uuidString
        realmCurrency.currencyCode = currency.currencyCode
        realmCurrency.currencyName = currency.currencyName
        
        do {
            try realm.write {
                realm.deleteAll()
                realm.add(realmCurrency)
            }
        } catch {
            throw error
        }
    }
    
    private func loadSelectedCurrency() -> CurrencyModel? {
        guard let realm = self.realm else {
            print("Realm is not initialized.")
            return nil
        }
        
        let selectedCurrencyObject = realm.objects(SelectedCurrency.self).first
        guard let realmCurrency = selectedCurrencyObject else { return nil }
        
        let currency = CurrencyModel(id: UUID(uuidString: realmCurrency.id) ?? UUID(),
                                     countryName: realmCurrency.currencyName,
                                     currencyCode: realmCurrency.currencyCode,
                                     currencyName: realmCurrency.currencyName)
        
        return currency
    }
}
