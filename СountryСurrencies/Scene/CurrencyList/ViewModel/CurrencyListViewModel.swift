//
//  CurrencyListViewModel.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import SwiftUI
import RealmSwift

class CurrencyListViewModel: ObservableObject {
    @Published var currencies: [CurrencyModel] = []
    @Published var exchangeRates: [String: Double] = [:]
    @Published var apiError: String?
    @Published var selectedCurrency: CurrencyModel?
    
    let apiService = APIService()
    
    private var notificationToken: NotificationToken?
    
    init() {
        loadCurrencies()
        observeRealmChanges()
    }

    func loadCurrencies() {
        self.currencies = CurrencyDataService.shared.loadCurrencies() ?? []
        self.selectedCurrency = loadSelectedCurrency()
        fetchAllExchangeRates()
    }
    
    func fetchAllExchangeRates() {
        let baseCurrency = selectedCurrency?.currencyCode ?? "UAH"
        apiService.fetchExchangeRate(baseCurrency: baseCurrency) { (response) in
            if let conversionRates = response?.conversionRates {
                DispatchQueue.main.async {
                    self.exchangeRates = conversionRates
                    self.apiError = nil
                }
            } else {
                DispatchQueue.main.async {
                    self.apiError = "Failed to get the list of currencies"
                }
            }
        }
    }
    
    private func loadSelectedCurrency() -> CurrencyModel? {
        do {
            let realm = try Realm()
            let selectedCurrencyObject = realm.objects(SelectedCurrency.self).first
            return mapToCurrencyModel(realmCurrency: selectedCurrencyObject)
        } catch {
            print("Failed to initialize Realm: \(error)")
            return nil
        }
    }
    
    private func mapToCurrencyModel(realmCurrency: SelectedCurrency?) -> CurrencyModel? {
        guard let realmCurrency = realmCurrency else { return nil }
        
        let currency = CurrencyModel(id: UUID(uuidString: realmCurrency.id) ?? UUID(),
                                     countryName: realmCurrency.currencyName,
                                     currencyCode: realmCurrency.currencyCode,
                                     currencyName: realmCurrency.currencyName)
        
        return currency
    }

    private func observeRealmChanges() {
        do {
            let realm = try Realm()
            self.notificationToken = realm.objects(SelectedCurrency.self).observe { [weak self] (changes: RealmCollectionChange) in
                switch changes {
                case .initial, .update:
                    DispatchQueue.main.async {
                        self?.selectedCurrency = self?.loadSelectedCurrency()
                        self?.fetchAllExchangeRates()
                    }
                case .error(let error):
                    print("Failed to fetch Realm objects: \(error)")
                }
            }
        } catch {
            print("Failed to setup Realm observer: \(error)")
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }

}


