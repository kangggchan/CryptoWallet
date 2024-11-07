//
//  ContentView.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var position1 = CGPoint(x: 0, y: 0)
    @State private var position2 = CGPoint(x: 100, y: 290)
    @State private var position3 = CGPoint(x: -100, y: -250)
        
    private let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                            Color(#colorLiteral(red: 0.1192055866, green: 0.1568120122, blue: 0.5431342721, alpha: 0.5500000119)),
                            Color(#colorLiteral(red: 0.684656024, green: 0.1043137535, blue: 0.4563552141, alpha: 0.5600000024)),
                            Color(#colorLiteral(red: 0.8373984694, green: 0.4771581888, blue: 0, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing
                      )
            .edgesIgnoringSafeArea(.all)
            Image("shape1").resizable().offset(y:-50)
            VStack {
                Spacer()
                HStack {
                    Text("wallet")
                        .font(.custom("Urbanist-Black", size: 60))
                        .foregroundColor(Color.white)
                    .padding(.top, 50)
                    Text("X")
                        .font(.custom("Urbanist-Black", size: 60))
                        .foregroundColor(.red)
                        .offset(y: 27)
                }
                Spacer()
                
                Image("center")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                Spacer()
                
                // Subtitle
                Text("Crypto control at your fingertips")
                    .font(.custom("Urbanist-Medium", size: 24))
                    .foregroundColor(Color.white)
                    .padding(.top, 20)
                Text("Take your investment portfolio to next level")
                    .font(.custom("Urbanist-Medium", size: 18))
                    .foregroundColor(Color.white.opacity(0.7))
                    .padding(.bottom, 30)
                    
                // Button
                Button(action: {
                    // Action for the button
                    print("Get Started button tapped")
                }) {
                    Text("Open your wallet")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 280, height: 50)
                        .background(Color.purple)
                        .cornerRadius(25)
                }
                .padding(.bottom, 40)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        .aspectRatio(contentMode: .fit)
        }
                
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GlassMorphicCard: View {
    var body: some View {
        let width = UIScreen.main.bounds.width
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .opacity(0.1)
                .background(
                    Color.white
                        .opacity(0.08)
                        .blur(radius: 10)
                )
            //Strokes
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(
                            .linearGradient(.init(colors: [
                                Color(Color.purple),
                                Color(Color.purple).opacity(0.5),
                                .clear,
                                .clear,
                                Color(Color.purple),
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing),
                            lineWidth: 2.5
                        )
                        .padding(2)
                
                )
                .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
            
        }
        .frame(width: width / 1.7, height: 270)
    }
}

