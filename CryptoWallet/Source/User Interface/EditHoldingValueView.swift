//
//  EditHoldingValueView.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 6/21/24.
//

import SwiftUI

struct EditHoldingValueView: View {
    
    var coinId: String?
    @Binding var newValue: String
    var onSave: (String) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("New Holding Value", text: $newValue)
                    .keyboardType(.decimalPad)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    onSave(newValue)
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Edit Holding Value")
            .navigationBarItems(leading: Button("Cancel") {
            })
        }
    }
}

