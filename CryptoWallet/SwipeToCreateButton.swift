//
//  SwipeToCreateButton.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/10/24.
//

import SwiftUI

struct SwipeToCreateButton: View {
    @State private var offset: CGFloat = 0
    private let buttonWidth: CGFloat = 300
    private let buttonHeight: CGFloat = 60
    private let dragThreshold: CGFloat = 240

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.black)
                .opacity(0.5)
                .frame(width: buttonWidth, height: buttonHeight)
            
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: buttonHeight, height: buttonHeight-5)
                    
                    Image(systemName: "arrow.right")
                        .foregroundColor(.black)
                }
                .offset(x: offset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.width > 0 && gesture.translation.width < dragThreshold {
                                offset = gesture.translation.width
                            }
                        }
                        .onEnded { gesture in
                            if gesture.translation.width >= dragThreshold {
                                // Action for button creation
                                withAnimation {
                                    offset = dragThreshold
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    // Reset position after action
                                    withAnimation {
                                        offset = 0
                                    }
                                }
                            } else {
                                withAnimation {
                                    offset = 0
                                }
                            }
                        }
                )
                
                Spacer()
                
                Text("Slide to open")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right.chevron.right")
                    .foregroundColor(.white)
                    .padding(.trailing)
            }
            .frame(width: buttonWidth, height: buttonHeight)
        }
        .padding()
    }
}

struct SwipeToCreateButton_Previews: PreviewProvider {
    static var previews: some View {
        SwipeToCreateButton()
    }
}
