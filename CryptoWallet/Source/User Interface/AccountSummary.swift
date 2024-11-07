//
//  AccountSummary.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/11/24.
//

import SwiftUI
import SwiftUICharts

struct AccountSummary: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
//            VStack {
//                HeaderView()
//                CurrentBalanceView()
//                AssetsListView()
//            }
//            .padding()
        }
    }
}

//struct HeaderView: View {
//    var body: some View {
//        HStack {
//            Image("profile") // Replace with the actual profile image name
//                .resizable()
//                .frame(width: 50, height: 50)
//                .clipShape(Circle())
//                .overlay(Circle().stroke(Color.white, lineWidth: 2))
//            
//            VStack(alignment: .leading) {
//                Text("Hello Alex")
//                    .font(.title)
//                    .foregroundColor(.white)
//                Spacer()
//            }
//            Spacer()
//            Button(action: {
//                // Settings action
//            }) {
//                Image(systemName: "gearshape.fill")
//                    .foregroundColor(.white)
//                    .font(.title)
//            }
//        }
//    }
//}
//
//struct CurrentBalanceView: View {
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Current Balance")
//                .foregroundColor(.gray)
//                .padding(.top, 20)
//            Text("$87,430.12")
//                .font(.largeTitle)
//                .foregroundColor(.white)
//            HStack {
//                Text("+ 10.2%")
//                    .foregroundColor(.blue)
//                Spacer()
//                LineChartView(data: [8, 7, 6, 9, 10, 9, 10], title: "", form: ChartForm.extraLarge)
//                    .padding(.leading)
//            }
//            .padding(.vertical, 10)
//        }
//        .padding()
//        .background(Color(#colorLiteral(red: 0.05882352941, green: 0, blue: 0.2352941176, alpha: 1)))
//        .cornerRadius(20)
//    }
//}
//
//struct AssetsListView: View {
//    var assets: [Asset] = [
//        Asset(name: "Ethereum", symbol: "ETH", value: "$503.12", amount: "50 ETH", trend: [5, 6, 7, 6, 8, 7, 9]),
//        Asset(name: "Bitcoin", symbol: "BTC", value: "$26927", amount: "2.05 BTC", trend: [8, 7, 6, 7, 8, 7, 6]),
//        Asset(name: "Litecoin", symbol: "LTC", value: "$6927", amount: "2.05 LTC", trend: [6, 7, 8, 6, 7, 8, 9]),
//        Asset(name: "Ripple", symbol: "XRP", value: "$4637", amount: "2.05 XRP", trend: [7, 8, 7, 9, 8, 9, 10])
//    ]
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack {
//                Text("Holdings")
//                    .foregroundColor(.white)
//                    .font(.title2)
//                Spacer()
//                Button(action: {
//                    // See All action
//                }) {
//                    Text("See All")
//                        .foregroundColor(.blue)
//                }
//            }
//            .padding(.vertical)
//            
//            ForEach(assets, id: \.symbol) { asset in
//                AssetRowView(asset: asset)
//            }
//        }
//    }
//}
//
//struct AssetRowView: View {
//    var asset: Asset
//    
//    var body: some View {
//        HStack {
//            Image(asset.symbol.lowercased()) // Replace with the actual asset image name
//                .resizable()
//                .frame(width: 40, height: 40)
//                .clipShape(Circle())
//                .overlay(Circle().stroke(Color.white, lineWidth: 1))
//            
//            VStack(alignment: .leading) {
//                Text(asset.name)
//                    .foregroundColor(.white)
//                    .font(.headline)
//                Text(asset.amount)
//                    .foregroundColor(.gray)
//            }
//            Spacer()
//            LineChartView(data: asset.trend, title: "", form: ChartForm.small)
//                .frame(width: 100, height: 50)
//            Text(asset.value)
//                .foregroundColor(.white)
//                .font(.headline)
//        }
//        .padding(.vertical, 10)
//    }
//}
//
//struct Asset: Identifiable {
//    let id = UUID()
//    var name: String
//    var symbol: String
//    var value: String
//    var amount: String
//    var trend: [Double]
//}

struct AccountSummary_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummary()
    }
}
