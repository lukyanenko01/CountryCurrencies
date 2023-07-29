//
//  CurrencyListPage.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import SwiftUI

struct CurrencyListPage: View {
    @StateObject var viewModel = CurrencyListViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(viewModel.currencies, id: \.currencyCode) { currency in
                        HStack {
                            if let img = UIImage(named: currency.currencyCode) {
                                Image(uiImage: img)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 50, height: 50)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(currency.currencyCode)
                                Text(currency.currencyName)
                            }
                            
                            Spacer()
                            
                            if let rate = viewModel.exchangeRates[currency.currencyCode] {
                                Text("\(rate)")
                            } else {
                                Text("Loading...")
                            }
                        }
                        .padding(.horizontal,12)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 5)
                        Divider()
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.homeDG.color).ignoresSafeArea())
            .navigationTitle("Currency List")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                HStack {
                Button { } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.gray.opacity(0.5))
                }
              }
            )
        }
    }
}

struct CurrencyListPage_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListPage()
    }
}
