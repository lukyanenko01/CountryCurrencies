//
//  SelectedCurrencyView.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 29.07.2023.
//

import SwiftUI

// Приймає одну вью модел від створення суммі і одну від налаштувань

//struct SelectedCurrencyView: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    
//    @StateObject var viewModel: SelectedCurrencyViewModel
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                ForEach(viewModel.currencies, id: \.id) { currency in
//                    HStack {
//                        if let img = UIImage(named: currency.currencyCode) {
//                            Image(uiImage: img)
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 30, height: 30)
//                                .clipShape(Circle())
//                        } else {
//                            Circle()
//                                .fill(Color.gray)
//                                .frame(width: 30, height: 30)
//                        }
//                        
//                        VStack(alignment: .leading) {
//                            Text(currency.currencyCode)
//                            Text(currency.currencyName)
//                                .font(.system(size: 13))
//                                .foregroundColor(.gray)
//                        }
//                        Spacer()
//                        
//                        Image(viewModel.selectedCurrency?.id == currency.id ? ImageAsset.radioChecked.rawValue : ImageAsset.radioUnchecked.rawValue)
//                            .renderingMode(.template)
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: 25, height: 25)
//                            .foregroundColor(viewModel.selectedCurrency?.id == currency.id ? .blue : .gray)
//                            .clipShape(Circle())
//                    }
//                    .padding(.horizontal,12)
//                    .frame(maxWidth: .infinity)
//                    .cornerRadius(10)
//                    .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 5)
//                    .onTapGesture {
//                        viewModel.selectedCurrency = currency
//                    }
//
//                    Divider()
//                }
//            }
//            .navigationTitle("Currency List")
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(leading: backButton)
//        }
//    }
//
//    @ViewBuilder
//    var backButton: some View {
//        Button(action: {
//            self.presentationMode.wrappedValue.dismiss()
//        }) {
//            HStack {
//                Image(systemName: "chevron.left")
//                    .aspectRatio(contentMode: .fit)
//                    .foregroundColor(.black)
//            }
//        }
//    }
//}
//
//struct SelectedCurrencyView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedCurrencyView(viewModel: SelectedCurrencyViewModel())
//    }
//}
