//
//  CreateWallet.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/10/24.
//

import SwiftUI

struct CreateWalletView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Crypto Wallet")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.title2)
                    .padding(.bottom, 5)
                
                Text("Create your\ncrypto wallet")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct CreateWalletView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWalletView()
    }
}

