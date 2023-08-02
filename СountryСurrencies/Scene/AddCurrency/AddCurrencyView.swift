//
//  AddCurrencyView.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 29.07.2023.
//

import SwiftUI

struct AddCurrencyView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: AddCurrencyViewModel

    @State private var ownedCurrencyValue = ""
    private let titleTextField = "Owned Value (UAH)"
    private let atribbuteField = "Enter Owned Currency Value"
    private let navigationTitle = "Add Owned Currency"


    
    var body: some View {
        VStack {
            CusstomTextFieldView(value: $ownedCurrencyValue, title: titleTextField, atribbute: atribbuteField)
            
            VStack(alignment: .leading) {
                Text("Select Country Currency")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top,30)
                
                NavigationLink(destination: SelectedCountryView(viewModel: viewModel)) {
                    HStack() {
                        if let img = UIImage(named: viewModel.selectedCurrency?.currencyCode ?? "") {
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
                        VStack(alignment: .leading) {
                            Text(viewModel.selectedCurrency?.currencyCode ?? "No Country Selected")
                            Text(viewModel.selectedCurrency?.currencyName ?? "--")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.black.opacity(0.4), lineWidth: 1)
                    )
                }
            }
            
            Spacer()
            
            Button {
                let ownedValue = Double(ownedCurrencyValue) ?? 0.0
                   if let currencyCode = viewModel.selectedCurrency?.currencyCode {
                       viewModel.addUserOwnedCurrency(currencyCode: currencyCode, ownedValue: ownedValue)
                   }
            } label: {
                Text("Add")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,9)
                    .background((viewModel.selectedCurrency == nil || ownedCurrencyValue.isEmpty) ? Color.gray : Color.blue)
                    .cornerRadius(10)
            }
            .disabled(viewModel.selectedCurrency == nil || ownedCurrencyValue.isEmpty)
            .padding()

            
        }
        .padding(.top, 30)
        .padding(.horizontal, 20)
        .navigationTitle(navigationTitle)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    @ViewBuilder
    var backButton : some View {
        Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Image(systemName: "chevron.left")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

struct AddCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        AddCurrencyView(viewModel: AddCurrencyViewModel())
    }
}


