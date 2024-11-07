//
//  CoinDetailView.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/24/24.
//

import SwiftUI

struct CoinDetailView: View {
    @ObservedObject var viewModel: CoinDetailViewModel
    
    var body: some View {
        HStack (spacing: 16){
            ForEach (viewModel.coins) { coin in
                AssetsColumnView(coin: coin)
                    .listRowInsets(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
            }
            
        }
        .padding()
            
        .onAppear {
            viewModel.fetchCoins()
        }
//        List(viewModel.coins) { coin in
//                    VStack(alignment: .leading) {
//                        Text(coin.name)
//                            .font(.headline)
//                        Text("Current Price: \(coin.currentPrice)")
//                            .font(.subheadline)
//                    }
//                }
//                .onAppear {
//                    viewModel.fetchCoins()
//                }
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(viewModel: CoinDetailViewModel())
    }
}

