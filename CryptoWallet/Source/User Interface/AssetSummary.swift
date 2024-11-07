//
//  AssetSummary.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/12/24.
//

import SwiftUI
import Charts

struct AssetSummary: View {
    
    let coin: Coin
    @StateObject private var miniChartVM = CoinChartViewModel(coinId: "")
    
    
    var body: some View {
        ZStack {
            
            HStack {
                // Coin Logo
                Image(coin.symbol.lowercased())
                    .resizable()
                    .frame(width: 40, height: 40)
                    .aspectRatio(contentMode: .fill)
                    .padding(.trailing, 5)
                    
                // Coin name
                VStack (alignment: .leading) {
                    Text(coin.name)
                        .font(.custom("Urbanist-Bold", size: 18))
                        .foregroundColor(Color("titleColor"))
                        
                        
                    Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                        .font(.custom("Urbanist-Bold", size: 14))
                        .foregroundColor(
                            (coin.priceChange24H ?? 0) >= 0 ?              Color.green :
                                Color.red
                        )
                        .offset(y: 1)
                }
                // Mini Chart
                Spacer()
                if miniChartVM.ohlcData.isEmpty {
                    Text("...")
                        .frame(height: 45)
                } else {
                    Chart {
                        let gradient = LinearGradient(
                            gradient: Gradient(colors: [(coin.priceChange24H ?? 0) >= 0 ? Color.green : Color.red, .clear]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        
                        ForEach(miniChartVM.ohlcData, id: \.timestamp) { ohlc in
                            LineMark(
                                x: .value("Time", Date(timeIntervalSince1970: ohlc.timestamp / 1000)),
                                y: .value("Close Price", ohlc.close)
                            )
                            .foregroundStyle(
                                (coin.priceChange24H ?? 0) >= 0 ?  Color.green :
                                    Color.red
                            )
                            
                            AreaMark(
                                x: .value("Time", Date(timeIntervalSince1970: ohlc.timestamp / 1000)),
                                yStart: .value("Close Price", ohlc.low),
                                yEnd: .value("Close Price", ohlc.close)
                            )
                            .foregroundStyle(gradient)
                        }
                    }
                    //.aspectRatio(contentMode: .fill)
                    .chartYAxis(.hidden)
                    .chartXAxis(.hidden)
                    
                    .chartYScale(domain: miniChartVM.ohlcData.map { $0.low }.min()!...miniChartVM.ohlcData.map { $0.high }.max()!)
                    .frame(width: 80 , height: 40)
                    .padding(.trailing, 20)
                }
                                    
                // Holding value
                VStack (alignment: .trailing) {
                    Text(((coin.currentHoldings ?? 0) * coin.currentPrice).asCurrencyWith2Decimals())
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color("titleColor"))
                    Text(String(coin.currentHoldings ?? 0) + " " + coin.symbol.uppercased())
                        .font(.custom("Urbanist-Medium", size: 14))
                        .foregroundColor(Color("titleColor"))
                        .offset(y: 1)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 15)
            
            
        }
        .background(.white)
        .cornerRadius(20)
        .onAppear {
            miniChartVM.coinId = coin.id
            miniChartVM.fetchOHLC(for: coin.id, timeframe: "1")
        }
        .frame(width: UIScreen.main.bounds.width - 30,height: 70)
        .background(.white)
        .cornerRadius(20)
    }
    
}

struct AssetSummary_Previews: PreviewProvider {
    static var previews: some View {
        AssetSummary(coin: dev.coin)
    }
}

