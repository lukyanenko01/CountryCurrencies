//
//  CusstomTextFieldView.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 29.07.2023.
//

import SwiftUI

struct CusstomTextFieldView: View {
    @Binding var value: String
    var title: String
    var atribbute: String
    var inputService = TextFieldInputService()

    var body: some View {
        VStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(atribbute, text: $value)
                .onChange(of: value) { newValue in
                    value = inputService.processTextFieldInput(input: newValue)
                }
                .multilineTextAlignment(.leading)
                .font(.title3)
                .padding(.vertical,7)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.black.opacity(0.4), lineWidth: 1)
                )
                .keyboardType(.numberPad)
        }
    }
}


