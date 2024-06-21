//
//  SegementedPicker.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/27/24.
//

import Foundation
import SwiftUI

struct SegmentedPicker: View {
    @Binding var selected: String
    let options: [String]

    private var selectedIndex: Int {
        get {
            return options.firstIndex(of: selected) ?? 0
        }
        set {
            selected = options[newValue]
        }
    }

    var body: some View {
        CustomSegmentedControl(preselectedIndex: Binding<Int>(
            get: { selectedIndex },
            set: { selectedIndex in
                withAnimation {
                    self.selected = options[selectedIndex]
                }
            }), options: options)
    }
}

struct CustomSegmentedControl: View {
    @Binding var preselectedIndex: Int
    var options: [String]
    let color = Color.red

    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id: \.self) { index in
                ZStack {
                    Rectangle()
                        .fill(color.opacity(0.2))

                    Rectangle()
                        .fill(color)
                        .cornerRadius(20)
                        .padding(2)
                        .opacity(preselectedIndex == index ? 1 : 0.01)
                        .onTapGesture {
                            withAnimation(.interactiveSpring()) {
                                preselectedIndex = index
                            }
                        }
                }
                .overlay(
                    Text(options[index])
                        .foregroundColor(preselectedIndex == index ? .white : .black) // Adjust text color for better visibility
                )
            }
        }
        .frame(height: 40)
        .cornerRadius(20)
    }
}

