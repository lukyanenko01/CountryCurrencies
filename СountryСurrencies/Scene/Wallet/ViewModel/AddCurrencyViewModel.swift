//
//  AddCurrencyViewModel.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 02.08.2023.
//

import SwiftUI
import RealmSwift

class AddCurrencyViewModel: CurrencyViewModelProtocol {
    var isAddCurrencyViewSource = true
    var selectedCurrencyInSettings: CurrencyModel?
    private var notificationToken: NotificationToken?
    
    @Published var apiError: String?
    @Published var exchangeRates: [String: Double] = [:]
    @Published var currencies: [CurrencyModel] = []
    @Published var selectedCurrency: CurrencyModel?
    @Published var userOwnedCurrencies: [UserOwnedCurrencyModel] = []
    
    var totalBalance: Double {
        userOwnedCurrencies.compactMap { currency in
            guard let exchangeRate = exchangeRates[currency.currencyCode] else { return nil }
            return currency.ownedValue * exchangeRate
        }.reduce(0, +)
    }


    let apiService = APIManager()
    
    init() {
        self.loadCurrencies()
        self.subscribeToChanges()
        self.fetchAllExchangeRates()
    }

    
    func loadCurrencies() {
        self.currencies = CurrencyDataService.shared.loadCurrencies() ?? []
    }
    
    func addUserOwnedCurrency(currencyCode: String, ownedValue: Double) {
        let userCurrency = UserOwnedCurrency()
        userCurrency.currencyCode = currencyCode
        userCurrency.ownedValue = ownedValue

        do {
            try RealmManager.shared.saveUserOwnedCurrency(userCurrency)
            self.userOwnedCurrencies = self.loadUserOwnedCurrency()
            print("Успешное сохранение валюты, принадлежащей пользователю")
        } catch {
            print("Не удалось сохранить валюту: \(error)")
        }
    }


    
    private func loadUserOwnedCurrency() -> [UserOwnedCurrencyModel] {
        return RealmManager.shared.loadUserOwnedCurrency().map { UserOwnedCurrencyModel(currency: $0) }
    }
    
    private func subscribeToChanges() {
        self.notificationToken = RealmManager.shared.observeUserOwnedCurrencies { [weak self] (changes) in
            switch changes {
            case .initial(let currencies):
                self?.userOwnedCurrencies = currencies.map(UserOwnedCurrencyModel.init(currency:))
            case .update(let currencies, _, _, _):
                self?.userOwnedCurrencies = currencies.map(UserOwnedCurrencyModel.init(currency:))
            case .error(let error):
                print("Failed to fetch user owned currencies: \(error)")
            }
        }
    }
    
    func fetchAllExchangeRates() {
        let baseCurrency = "USD"
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
    
    func removeUserOwnedCurrency(currencyId: UUID) {
        do {
            try RealmManager.shared.deleteUserOwnedCurrency(currencyId: currencyId)
        } catch {
            print("Failed to delete currency: \(error)")
        }
    }

    
}
