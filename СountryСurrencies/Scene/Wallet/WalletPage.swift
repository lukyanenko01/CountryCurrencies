//
//  WalletPage.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import SwiftUI

struct WalletPage: View {
    
    @State private var isSearching = false
    @State private var searchText = ""
    @State private var isAddOwnedCurrency = false
    
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
                    Text("$ 0.00")
                        .font(.system(size: 48))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
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
                NavigationLink(destination: AddCurrencyView(), isActive: $isAddOwnedCurrency) {
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
        }
        
        
    }
}

struct WalletPage_Previews: PreviewProvider {
    static var previews: some View {
        WalletPage()
    }
}
