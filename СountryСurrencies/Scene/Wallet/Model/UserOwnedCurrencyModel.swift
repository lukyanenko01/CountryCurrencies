//
//  UserOwnedCurrencyModel.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 02.08.2023.
//

import SwiftUI
import RealmSwift


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
