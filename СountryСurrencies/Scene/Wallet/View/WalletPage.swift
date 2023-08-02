//
//  WalletPage.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import SwiftUI

struct WalletPage: View {
    @State private var isdelete = false
    @State private var isSearching = false
    @State private var searchText = ""
    @State private var isAddOwnedCurrency = false
    @ObservedObject var viewModel: AddCurrencyViewModel
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    if isSearching {
                        TextField("Search...", text: $searchText)
                            .padding(7)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    Text("Tatal Balance")
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Text(String(format: "$ %.2f", viewModel.totalBalance))
                        .font(.system(size: 48))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    if viewModel.userOwnedCurrencies.isEmpty {
                        Text("No saved currencies yet")
                            .foregroundColor(.gray)
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal)
                        
                    } else {
                        ForEach(viewModel.userOwnedCurrencies.filter({ $0.currencyCode.lowercased().contains(searchText.lowercased()) || searchText.isEmpty }), id: \.id) { currency in
                            HStack {
                                
                                if isdelete {
                                    Button(action: {
                                        deleteCurrency(currency: currency)
                                    }) {
                                        Image(systemName: "minus")
                                            .imageScale(.large)
                                            .foregroundColor(.red)
                                    }
                                }
                                
                                if let img = UIImage(named: currency.currencyCode) {
                                    Image(uiImage: img)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                } else {
                                    Circle()
                                        .fill(Color.gray)
                                        .frame(width: 60, height: 60)
                                }
                                
                                VStack {
                                    Text(currency.currencyCode)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    if let exchangeRate = viewModel.exchangeRates[currency.currencyCode] {
                                        let rate = String(format: "$%.2f", exchangeRate * currency.ownedValue)
                                        Text("\(rate)")
                                            .font(.system(size: 13))
                                            .foregroundColor(.gray)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    } else {
                                        Text("Loading...")
                                            .font(.system(size: 13))
                                            .foregroundColor(.gray)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    
                                }
                                .padding(.horizontal,10)
                                
                                Spacer()
                                
                                Text(String(format: "%.2f", currency.ownedValue))
                                
                                
                            }
                            .padding(.horizontal,12)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 5)
                            Divider()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.homeDG.color).ignoresSafeArea())
            .navigationTitle("Wallet")
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
                NavigationLink(destination: AddCurrencyView(viewModel: viewModel), isActive: $isAddOwnedCurrency) {
                    Button {
                        isAddOwnedCurrency.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.gray.opacity(0.5))
                    }
                }
            }
                                
            )
            .navigationBarItems(leading:
                                    Button {
                isdelete.toggle()
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(isdelete ? .red.opacity(0.5) : .gray.opacity(0.5))
            }
                                
            )
        }
        
        
    }
    
    func deleteCurrency(currency: UserOwnedCurrencyModel) {
        if let uuid = UUID(uuidString: currency.id) {
            viewModel.removeUserOwnedCurrency(currencyId: uuid)
        }
    }
}

struct WalletPage_Previews: PreviewProvider {
    static var previews: some View {
        WalletPage(viewModel: AddCurrencyViewModel())
    }
}
