//
//  AssestDetailView.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/12/24.
//

import SwiftUI
import Charts

struct AssetDetailView: View {
    
    let coin: Coin
    @ObservedObject var CoinChartVM: CoinChartViewModel
        
    @State var selectedChartType = "Line"
    var charts = ["Line", "Candle"]
    var chartImages: [String: Image] = [
            "Line": Image("lineChart"),
            "Candle": Image("candleChart")
    ]
    @State private var selectedTimeframe: Timeframe = .sevenDays
    
        
        
    enum Timeframe: String, CaseIterable, Identifiable {
        
        case oneDay = "24H"
        case sevenDays = "7D"
        case oneMonth = "1M"
        case oneYear = "1Y"
        
        var id: String { self.rawValue }
        
        var apiValue: String {
            
            switch self {
            case .oneDay: return "1"
            case .sevenDays: return "7"
            case .oneMonth: return "31"
            case .oneYear: return "365"
            }
        }
    }
    
    
    init(coin: Coin, CoinChartVM: CoinChartViewModel) {
        self.coin = coin
        self.CoinChartVM = CoinChartVM
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Image(coin.symbol.lowercased())
                    .resizable()
                    .frame(width: 35, height: 35)
                    .aspectRatio(contentMode: .fill)
                    .padding(.trailing, 5)
                
                Text(coin.name + " (" + coin.symbol.uppercased() + ")")
                    .font(.custom("Urbanist-Bold", size: 24))
            }.padding(.top)
            
            HStack {
                Image(systemName: 
                        (coin.priceChange24H ?? 0) >= 0 ?  "chevron.up" :
                        "chevron.down")
                    .foregroundColor(
                        (coin.priceChange24H ?? 0) >= 0 ?  Color.green :
                            Color.red
                    )
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.secondary)
            }.padding(.bottom, 30)
            
            HStack {
                Text("Statictis")
                    .font(.custom("Urbanist-Bold", size: 24))
                    .padding()
                Spacer()
                SegmentedPicker(selected: $selectedChartType, options: charts, images: chartImages)
                    .offset(x: -15)
            }
            // Chart View
            if CoinChartVM.ohlcData.isEmpty {   Text("Loading...").font(.custom("Urbanist-Regular", size: 20))  }
            else {

                if selectedChartType == charts[0] {
                    LineChartView(ohlcData: CoinChartVM.ohlcData)
                        .frame(width: UIScreen.main.bounds.width - 30, height: 200)
                        .padding()
                } else {
                    CandleChartView(ohlcData: CoinChartVM.ohlcData)
                        .frame(width: UIScreen.main.bounds.width - 30, height: 200)
                        .padding()
                }
                
                Picker("Timeframe", selection: $selectedTimeframe) {
                    ForEach(Timeframe.allCases) { timeframe in
                        Text(timeframe.rawValue).tag(timeframe)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            
            List {
                HStack {
                    Text("Current Price")
                        .font(.custom("Urbanist-Regular", size: 18))
                    Spacer()
                    Text(coin.currentPrice.asCurrencyWith2Decimals())
                        .font(.custom("Urbanist-Regular", size: 18))
                }
                HStack {
                    Text("Market Cap")
                        .font(.custom("Urbanist-Regular", size: 18))
                    Spacer()
                    Text(coin.marketCap?.formattedWithAbbreviations() ?? "")
                        .font(.custom("Urbanist-Regular", size: 18))
                }
                HStack {
                    Text("Price Change 24H")
                        .font(.custom("Urbanist-Regular", size: 18))
                    Spacer()
                    Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                        .font(.custom("Urbanist-Regular", size: 18))
                }
                HStack {
                    Text("Ranking")
                        .font(.custom("Urbanist-Regular", size: 18))
                    Spacer()
                    Text(coin.marketCapRank?.asNumberString2() ?? "")
                        .font(.custom("Urbanist-Regular", size: 18))
                }
                HStack {
                    Text("Total Supply")
                        .font(.custom("Urbanist-Regular", size: 18))
                    Spacer()
                    Text(coin.totalSupply?.asNumberString2() ?? "")
                        .font(.custom("Urbanist-Regular", size: 18))
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            CoinChartVM.fetchOHLC(for: CoinChartVM.coinId, timeframe: selectedTimeframe.apiValue)
        }
        .onChange(of: selectedTimeframe) { newTimeframe in
            CoinChartVM.fetchOHLC(for: CoinChartVM.coinId, timeframe: newTimeframe.apiValue)
        }
    }
}
struct AssetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AssetDetailView(coin: dev.coin, CoinChartVM: CoinChartViewModel(coinId: "bitcoin"))
    }
}



struct LineChartView: View {
    var ohlcData: [OHLC]
    
    var body: some View {
        Chart {
            ForEach(ohlcData, id: \.timestamp) { ohlc in
                LineMark(
                    x: .value("Time", Date(timeIntervalSince1970: ohlc.timestamp / 1000)),
                    y: .value("Close Price", ohlc.close)
                )
                .foregroundStyle(.blue)
            }
        }
        .chartYScale(domain: ohlcData.map { $0.low }.min()!...ohlcData.map { $0.high }.max()!)
    }
}

struct CandleChartView: View {
    var ohlcData: [OHLC]
    
    var body: some View {
        Chart {
            ForEach(ohlcData, id: \.timestamp) { ohlc in
                RectangleMark(
                    x: .value("Day", Date(timeIntervalSince1970: ohlc.timestamp / 1000)),
                    yStart: .value("Low Price", ohlc.low),
                    yEnd: .value("High Price", ohlc.high),
                    width: 1
                )
                .opacity(0.4)
                .foregroundStyle(
                    (ohlc.close >= ohlc.open) ?
                    Color.green : Color.red
                )
                
                RectangleMark(
                    x: .value("Day", Date(timeIntervalSince1970: ohlc.timestamp / 1000)),
                    yStart: .value("Open Price", ohlc.open),
                    yEnd: .value("Close Price", ohlc.close),
                    width: 4
                )
                .foregroundStyle(
                    (ohlc.close >= ohlc.open) ?
                    Color.green : Color.red
                )
            }
        }
        .chartYScale(domain: ohlcData.map { $0.low }.min()!...ohlcData.map { $0.high }.max()!)
    }
}
