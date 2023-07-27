//
//  WalletPage.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import SwiftUI

struct WalletPage: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Wallet")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.homeDG.color).ignoresSafeArea())
            .navigationTitle("Wallet")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                HStack {
                Button { } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.gray.opacity(0.5))
                }
                Button { } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.gray.opacity(0.5))
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
