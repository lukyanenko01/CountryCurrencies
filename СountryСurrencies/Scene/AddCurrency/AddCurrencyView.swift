//
//  AddCurrencyView.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 29.07.2023.
//

import SwiftUI

struct AddCurrencyView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                
                NavigationLink(destination: EmptyView()) {
                    HStack() {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 50, height: 50)
                        
                        VStack(alignment: .leading) {
                            Text("currencyCode")
                            Text("currencyName")
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
            
        }
        .padding(.top, 30)
        .padding(.horizontal, 20)
        .navigationTitle(navigationTitle)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
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
}

struct AddCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        AddCurrencyView()
    }
}


