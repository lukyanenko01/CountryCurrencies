//
//  SettingsPage.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 27.07.2023.
//

import SwiftUI

struct SettingsPage: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Settings")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ColorAsset.homeDG.color).ignoresSafeArea())
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
