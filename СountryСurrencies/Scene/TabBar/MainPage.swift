//
//  MainPage.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import SwiftUI

struct MainPage: View {
    
    @State var currenTab: Tab = .currencyListPage
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            TabView(selection: $currenTab) {
                
                CurrencyListPage()
                    .tag(Tab.currencyListPage)
                
                WalletPage(viewModel: AddCurrencyViewModel())
                    .tag(Tab.walletPage)
                
                BidsPage()
                    .tag(Tab.bidsPage)
                
                SettingsPage(viewModel: SettingsCurrencyViewModel())
                    .tag(Tab.settingsPage)
            }
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    
                    Button {
                        currenTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .background(
                                Color(ColorAsset.selectTab.color)
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                    .blur(radius: 5)
                                    .padding(-7)
                                    .opacity(currenTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currenTab == tab ? Color(ColorAsset.selectTab.color) : .black.opacity(0.3))
                    }
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom,10)
        }
        .background(Color(ColorAsset.homeDG.color).ignoresSafeArea())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}








