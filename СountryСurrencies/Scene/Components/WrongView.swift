//
//  WrongView.swift
//  СountryСurrencies
//
//  Created by Vladimir Lukyanenko on 02.08.2023.
//

import SwiftUI

struct WrongView: View {
    var retryAction: () -> Void

    var body: some View {
        VStack {
            ImageAsset.wrong.image
            Text("Something went wrong while fetching data. Please, try again")
                .multilineTextAlignment(.center)
                .padding(40)
                .font(.system(size: 20))
            
            Button(action: retryAction) {
                Text("Retry")
                    .foregroundColor(.white)
                    .padding(.horizontal, 70)
            }
            .padding()
            .background(Color(ColorAsset.retryButton.color))
            .cornerRadius(8)
        }
    }
}

//struct WrongView_Previews: PreviewProvider {
//    static var previews: some View {
//        WrongView()
//    }
//}
