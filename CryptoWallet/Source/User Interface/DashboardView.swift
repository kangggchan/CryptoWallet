//
//  Dashboard.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/12/24.
//

import SwiftUI
import Neumorphic

struct DashboardView: View {
    
    @EnvironmentObject private var vm: DashboardViewModel
    @State private var showPortfolio: Bool = false
    
    
    var body: some View {
        VStack {
            //Header
            HStack  {
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .overlay{
                        Circle().stroke(.white, lineWidth: 1).frame(width: 60, height: 60)
                    }
                
                VStack (alignment: .leading) {
                    Text("kangggchan")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding(.leading, 10)
                    .foregroundColor(Color("titleColor"))
                    Text("Welcome back!")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                    .padding(.leading, 10)
                    .foregroundColor(Color("textColor"))
                }
                Spacer()
                
                Image(systemName: "bell").resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18)
                    .foregroundColor(Color("titleColor"))
                    .overlay{
                        Circle().stroke(Color("textColor"), lineWidth: 1).frame(width: 30, height: 30)
                            
                    }
                    .padding(.trailing, 20)
                
            }.padding(.horizontal, 10)
            
            ScrollView {
                VStack (alignment: .leading) {
                    //Balance View
                    ZStack (alignment: .topLeading) {
                        Color.Neumorphic.main
                            .cornerRadius(15)
                            .softOuterShadow()
                            .frame(width: UIScreen.main.bounds.width - 30, height: 160)
                        VStack (alignment: .leading) {
                            Text("Total Balance").font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color("textColor"))
                                .padding(.init(top: 20, leading: 20, bottom: 1, trailing: 0))
                            HStack (alignment: .bottom) {
                                Text(DeveloperPreview.instance.coin.currentHoldingsValue.asCurrencyWith6Decimals().prefix(1))
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundColor(Color("textColor"))
                                Text(DeveloperPreview.instance.coin.currentHoldingsValue.asCurrencyWith6Decimals().dropFirst()).font(.system(size: 32, weight: .bold))
                                    .foregroundColor(Color("titleColor"))
                            }
                            .padding(.init(top: 0, leading: 20, bottom: 5, trailing: 0))
                            HStack (alignment: .center) {
                                Image(systemName: "arrow.up.right")
                                    .foregroundColor(Color("winColor"))
                                    .background(
                                        Color.white.frame(width: 25, height: 25)
                                            .cornerRadius(5)
                                    )
                                Text("Weekly Profit:").font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color("textColor"))
                                    .padding(.leading, 5)
                                
                                Text("+2.5%")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color("winColor"))
                                
                            }.padding(.leading, 23)
                        }
                    }.padding(.all, 15)
                    
                    
                    Text("Hot Assets")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(Color("titleColor"))
                        .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 0))
                    // Top Coin ScrollView
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack (spacing: 16){
                            ForEach (vm.allCoins) { coin in
                                AssetsColumnView(coin: coin)
                            }
                        }.padding()
                    }
                    
                    Text("My Portfolio")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(Color("titleColor"))
                        .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 0))
                    // My portfolio
                    VStack (spacing: 16) {
                        AssetSummary(coin: DeveloperPreview.instance.coin).background(Color.Neumorphic.main.cornerRadius(20))
                            .softOuterShadow()
                        AssetSummary(coin: DeveloperPreview.instance.coin).background(Color.Neumorphic.main.cornerRadius(20))
                            .softOuterShadow()
                        AssetSummary(coin: DeveloperPreview.instance.coin).background(Color.Neumorphic.main.cornerRadius(20))
                            .softOuterShadow()
                        AssetSummary(coin: DeveloperPreview.instance.coin).background(Color.Neumorphic.main.cornerRadius(20))
                            .softOuterShadow()
                    }
                    .listStyle(PlainListStyle())
                    .scrollDisabled(false)
                    .padding()
                    
                }
            }
            
        }.background(Color.Neumorphic.main.edgesIgnoringSafeArea(.all))
        
        
        VStack {
            
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                            Color(#colorLiteral(red: 0.1870824397, green: 0.1145269945, blue: 0.3790853024, alpha: 1)),
                            Color(#colorLiteral(red: 0.08431015164, green: 0.1747906804, blue: 0.282925427, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing
                      )
            .edgesIgnoringSafeArea(.all))
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
