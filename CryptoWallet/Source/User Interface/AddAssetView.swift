//
//  AddAssetView.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 6/21/24.
//

import SwiftUI

struct AddAssetView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var HoldingCoinsVM: HoldingCoinModel
    
    @State private var coinId: String = ""
    @State private var holdingValue: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add New Asset")) {
                    TextField("Coin ID", text: $coinId)
                    TextField("Holding Value", text: $holdingValue)
                        .keyboardType(.decimalPad)
                }
                
                Button(action: {
                    if let holdingValue = Double(holdingValue) {
                        let newCoin = HoldingCoins(id: coinId, image: "", holdingValue: holdingValue)
                        HoldingCoinsVM.addCoin(newCoin)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Add Asset")
                }
            }
            .navigationBarTitle("Add Asset", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

