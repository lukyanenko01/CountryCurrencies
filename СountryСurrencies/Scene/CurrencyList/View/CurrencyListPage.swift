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
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.apiError != nil {
                    WrongView(retryAction: viewModel.reloadData)
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

struct CurrencyListPage_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListPage()
    }
}
