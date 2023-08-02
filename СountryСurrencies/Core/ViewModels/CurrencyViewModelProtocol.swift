//
//  CurrencyViewModelProtocol.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 29.07.2023.
//

import SwiftUI
import RealmSwift

protocol CurrencyViewModelProtocol: ObservableObject {
    var isAddCurrencyViewSource: Bool { get set }
    var currencies: [CurrencyModel] { get set }
    var selectedCurrency: CurrencyModel? { get set }
    var selectedCurrencyInSettings: CurrencyModel? { get set }
    func loadCurrencies()
}



