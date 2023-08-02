//
//  SelectedCurrency.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 29.07.2023.
//

import RealmSwift
import Foundation

class SelectedCurrency: Object {
    @objc dynamic var id = ""
    @objc dynamic var currencyCode = ""
    @objc dynamic var currencyName = ""
    
}

