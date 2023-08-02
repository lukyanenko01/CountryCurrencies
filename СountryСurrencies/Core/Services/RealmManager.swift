//
//  RealmManager.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 29.07.2023.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private var realm: Realm?
    
    private init() {
        do {
            self.realm = try Realm()
        } catch {
            print("Failed to initialize Realm: \(error)")
        }
    }
    
    func saveSelectedCurrency(_ currency: CurrencyModel) throws {
        guard let realm = self.realm else {
            print("Realm is not initialized.")
            throw RealmError.initializationError
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
            throw RealmError.writeError
        }
    }
    
    func loadSelectedCurrency() -> CurrencyModel? {
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
    
    func observeRealmChanges(completion: @escaping (RealmCollectionChange<Results<SelectedCurrency>>) -> Void) -> NotificationToken? {
        do {
            let realm = try Realm()
            let notificationToken = realm.objects(SelectedCurrency.self).observe { (changes: RealmCollectionChange) in
                completion(changes)
            }
            return notificationToken
        } catch {
            print("Failed to setup Realm observer: \(error)")
            return nil
        }
    }
    
    
    func saveUserOwnedCurrency(_ currency: UserOwnedCurrency) throws {
        guard let realm = self.realm else {
            print("Realm is not initialized.")
            throw RealmError.initializationError
        }
        
        do {
            try realm.write {
                realm.add(currency, update: .modified)
            }
        } catch {
            throw RealmError.writeError
        }
    }

    func loadUserOwnedCurrency() -> [UserOwnedCurrency] {
        guard let realm = self.realm else {
            print("Realm is not initialized.")
            return []
        }
        
        let userOwnedCurrencies = Array(realm.objects(UserOwnedCurrency.self))
        return userOwnedCurrencies
    }
    
    func observeUserOwnedCurrencies(completion: @escaping (RealmCollectionChange<Results<UserOwnedCurrency>>) -> Void) -> NotificationToken? {
        guard let realm = self.realm else {
            print("Realm is not initialized.")
            return nil
        }
        let notificationToken = realm.objects(UserOwnedCurrency.self).observe { (changes: RealmCollectionChange) in
            completion(changes)
        }
        return notificationToken
    }

    enum RealmError: Error {
        case initializationError
        case writeError
    }
}

