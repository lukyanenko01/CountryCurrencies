//
//  SettingsPage.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import SwiftUI

struct SettingsPage: View {
    
    @ObservedObject var viewModel: SettingsCurrencyViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SelectedCountryView(viewModel: viewModel)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Selected Currency:")
                            Text(viewModel.selectedCurrencyInSettings?.countryName ?? "Ukraine")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        if let img = UIImage(named: viewModel.selectedCurrencyInSettings?.currencyCode ?? "UAH") {
                            Image(uiImage: img)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 44, height: 44)
                        }
                    }
                    
                    .padding(.top,30)
                    .padding(.horizontal,20)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 5)
                }
                Divider()
                    .padding()
                Spacer()
            }
           
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(ColorAsset.homeDG.color).ignoresSafeArea())
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage(viewModel: SettingsCurrencyViewModel())
    }
}
