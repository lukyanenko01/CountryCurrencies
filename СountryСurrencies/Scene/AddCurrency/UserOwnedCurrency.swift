//
//  UserOwnedCurrency.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 31.07.2023.
//

import Foundation
import RealmSwift

class UserOwnedCurrency: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var currencyCode: String = ""
    @objc dynamic var ownedValue: Double = 0.0

    override static func primaryKey() -> String? {
        return "id"
    }
}

