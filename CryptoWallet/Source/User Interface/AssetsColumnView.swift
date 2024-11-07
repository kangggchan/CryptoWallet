//
//  AssetsColumnView.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/14/24.
//

import SwiftUI

struct AssetsColumnView: View {
    
    let coin: Coin
    
    var body: some View {
        VStack{
            // Coin name, logo
            HStack{
                VStack (alignment: .leading){
                    Text(coin.name)
                        .font(.custom("Urbanist-Bold", size: 18))
                        .foregroundColor(Color("titleColor"))
                    Text(coin.symbol.uppercased())
                        .font(.custom("Urbanist-Medium", size: 16))
                        .foregroundColor(Color("titleColor"))
                }
                Spacer()
                
                Image(coin.symbol.lowercased())
                    .resizable()
                    .frame(width: 35, height: 35)
                    .aspectRatio(contentMode: .fill)
                    .padding(.trailing, 5)
                
            }
            .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 20))
            Spacer()
            // Coin Price
            HStack (alignment: .bottom) {
                Text(coin.currentPrice.asCurrencyWith6Decimals().prefix(1))
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(Color("textColor"))
                    .offset(y: 1)
                Text(coin.currentPrice.asCurrencyWith6Decimals().dropFirst())
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color("titleColor"))
                    .offset(x: -7, y: 2)
                Spacer()
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                    .font(.custom("Urbanist-Bold", size: 14))
                    .foregroundColor(
                        (coin.priceChange24H ?? 0) >= 0 ?              Color("winColor") : Color("loseColor")
                    )
            }
            .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 20))
        }
        .frame(width: UIScreen.main.bounds.width / 2,height: 130)
        .background(.white)
        .cornerRadius(20)
        //.softOuterShadow()
    }
}

struct AssetsColumnView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsColumnView(coin: dev.coin)
    }
}
