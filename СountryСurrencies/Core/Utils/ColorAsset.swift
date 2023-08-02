//
//  ColorAsset.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import SwiftUI

enum ColorAsset: String {
    case homeDG
    case selectTab
    case retryButton

    var color: UIColor {
        return UIColor(named: self.rawValue) ?? UIColor()
    }
    
    var cgColor: CGColor {
        return self.color.cgColor
    }
}
