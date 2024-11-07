//
//  CryptoWalletApp.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/10/24.
//

import SwiftUI

@main
struct CryptoWalletApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView(TopCoinsVM: CoinDetailViewModel())
        }
    }
}
