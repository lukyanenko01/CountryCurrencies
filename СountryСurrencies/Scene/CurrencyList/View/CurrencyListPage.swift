//
//  CurrencyListPage.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import SwiftUI

struct CurrencyListPage: View {
    @StateObject var viewModel = CurrencyListViewModel()
    @State private var isSearching = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            Group {
                if let error = viewModel.apiError {
                    VStack {
                        Text("Error: \(error)")
                        Text("Try again later")
                    }
                } else {
                    Group {
                        ScrollView {
                            VStack {
                                if isSearching {
                                    TextField("Search...", text: $searchText)
                                        .padding(7)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(8)
                                }
                            
                                ForEach(viewModel.currencies.filter({ currency in
                                    searchText.isEmpty || currency.currencyName.lowercased().contains(searchText.lowercased())
                                }), id: \.currencyCode) { currency in
                                    CurrencyRow(currency: currency,
                                                rate: viewModel.exchangeRates[currency.currencyCode],
                                                baseCurrencyCode: viewModel.selectedCurrency?.currencyCode)
                                    Divider()
                                }
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
                            Button {
                                isSearching.toggle()
                            } label: {
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
    }
}


//struct CurrencyListPage_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrencyListPage()
//    }
//}

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
