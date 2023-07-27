//
//  BidsPage.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import SwiftUI

struct BidsPage: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Bids")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.homeDG.color).ignoresSafeArea())
            .navigationTitle("Bids")
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

struct BidsPage_Previews: PreviewProvider {
    static var previews: some View {
        BidsPage()
    }
}
