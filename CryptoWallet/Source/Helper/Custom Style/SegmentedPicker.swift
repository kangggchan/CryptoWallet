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
    var options: [String]
    var images: [String: Image]

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
            }), options: options, images: images)
    }
}

struct CustomSegmentedControl: View {
    @Binding var preselectedIndex: Int
    var options: [String]
    var images: [String: Image]
    let color = Color.blue
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id: \.self) { index in
                HStack {
                    images[options[index]]?
                        .resizable()
                        .frame(width: 15, height: 15)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(preselectedIndex == index ? .black : .gray)
                    Text(options[index])
                        .font(.custom("Urbanist-Medium", size: 14))
                        .foregroundColor(preselectedIndex == index ? .black : .gray)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 15)
                .background((Color.white).opacity(preselectedIndex == index ? 1 : 0))
                .clipShape(Capsule())
                .onTapGesture {
                    withAnimation(.interactiveSpring()) {
                        preselectedIndex = index
                    }
                }
            }
        }
        .padding(3)
        .background(Color.black.opacity(0.06))
        .clipShape(Capsule())
    }
}

struct SegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPicker(
            selected: .constant("Line"),
            options: ["Line", "Candle"],
            images: [
                "Line": Image("lineChart"),
                "Candle": Image("candleChart")
            ]
        )
    }
}
