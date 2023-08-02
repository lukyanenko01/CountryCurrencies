//
//  SelectedCurrencyViewModel.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 29.07.2023.
//

import SwiftUI
import RealmSwift

//class SelectedCurrencyViewModel: ObservableObject {
//    
//    @Published var currencies: [CurrencyModel] = []
//    @Published var selectedCurrency: CurrencyModel?
//    
//    @Published var selectedCurrencyInSettings: CurrencyModel? {
//        didSet {
//            guard let selectedCurrency = selectedCurrencyInSettings else { return }
//            do {
//                try saveSelectedCurrency(selectedCurrency)
//            } catch {
//                print("Failed to save selected currency: \(error)")
//            }
//        }
//    }
//    
//    @Published var userOwnedCurrencies: [UserOwnedCurrency] = []
//
//    
//    let apiService = APIManager()
//    
////    init() {
////        self.loadCurrencies()
////        self.userOwnedCurrencies = self.loadUserOwnedCurrency()
////
////        if let savedCurrency = RealmManager.shared.loadSelectedCurrency() {
////            self.selectedCurrencyInSettings = savedCurrency
////        }
////    }
//    
//    func loadCurrencies() {
//        self.currencies = CurrencyDataService.shared.loadCurrencies() ?? []
//    }
//    
//    
//    private func saveSelectedCurrency(_ currency: CurrencyModel) throws {
//        try RealmManager.shared.saveSelectedCurrency(currency)
//    }
//    
//    private func loadSelectedCurrency() -> CurrencyModel? {
//        return RealmManager.shared.loadSelectedCurrency()
//    }
//    
////    func addUserOwnedCurrency(currencyCode: String, ownedValue: Double) {
////        let userCurrency = UserOwnedCurrency()
////        userCurrency.currencyCode = currencyCode
////        userCurrency.ownedValue = ownedValue
////
////        do {
////            try RealmManager.shared.saveUserOwnedCurrency(userCurrency)
////            self.userOwnedCurrencies = self.loadUserOwnedCurrency()
////        } catch {
////            print("Failed to save user owned currency: \(error)")
////        }
////    }
////
////    private func loadUserOwnedCurrency() -> [UserOwnedCurrency] {
////        return RealmManager.shared.loadUserOwnedCurrency()
////    }
//
//}

class AddCurrencyViewModel: CurrencyViewModelProtocol {
    var isAddCurrencyViewSource = true
    var selectedCurrencyInSettings: CurrencyModel?
    private var notificationToken: NotificationToken?
    
    @Published var currencies: [CurrencyModel] = []
    
    @Published var selectedCurrency: CurrencyModel?
    
    @Published var userOwnedCurrencies: [UserOwnedCurrencyModel] = []

    let apiService = APIManager()
    
    init() {
        self.loadCurrencies()
        self.subscribeToChanges()
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
    
}

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

protocol CurrencyViewModelProtocol: ObservableObject {
    var isAddCurrencyViewSource: Bool { get set }
    var currencies: [CurrencyModel] { get set }
    var selectedCurrency: CurrencyModel? { get set }
    var selectedCurrencyInSettings: CurrencyModel? { get set }
    func loadCurrencies()
}


class UserOwnedCurrencyModel: Identifiable {
    let id: String
    let currencyCode: String
    let ownedValue: Double
    
    init(currency: UserOwnedCurrency) {
        self.id = currency.id
        self.currencyCode = currency.currencyCode
        self.ownedValue = currency.ownedValue
    }
}
