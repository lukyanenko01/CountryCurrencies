//
//  TextFieldInputService.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 29.07.2023.
//

import UIKit

class TextFieldInputService {
    func processTextFieldInput(input: String) -> String {
        if input.count > 10 {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            return String(input.prefix(10))
        } else if !input.allSatisfy({ $0.isNumber }) {
            return String(input.filter { $0.isNumber })
        } else {
            return input
        }
    }
}

