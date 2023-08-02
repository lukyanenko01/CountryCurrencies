//
//  ImageAsset.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 29.07.2023.
//

import SwiftUI

enum ImageAsset: String {
    case radioChecked
    case radioUnchecked
    case wrong
    
    var image: Image {
        return(Image(self.rawValue))
    }
    
}
