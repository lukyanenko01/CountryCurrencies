//
//  CurrencyRow.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 29.07.2023.
//

import SwiftUI

struct CurrencyRow: View {
    var currency: CurrencyModel
    var rate: Double?
    var baseCurrencyCode: String?
    
    var body: some View {
        HStack {
            if let img = UIImage(named: currency.currencyCode) {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 30, height: 30)
            }
            
            HStack {
                Text(currency.currencyCode)
                Text(currency.currencyName)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            if let rate = rate {
                HStack {
                    Text(String(format: "%.2f", rate))
                    Text(baseCurrencyCode ?? "UAH")
                }
            } else {
                Text("Loading...")
            }
        }
        .padding(.horizontal,12)
        .frame(maxWidth: .infinity)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

