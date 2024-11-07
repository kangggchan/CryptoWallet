//
//  Dashboard.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/12/24.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject var TopCoinsVM = CoinDetailViewModel()
    @ObservedObject var HoldingCoinsVM = HoldingCoinModel()
    
    @State private var showAddAssetView = false
    @State private var isEditing = false
    @State private var showEditHoldingValueSheet = false
    @State private var selectedCoinId: String?
    @State private var newHoldingValue: String = ""
    
    var body: some View {
        NavigationView {
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
                }.padding(.horizontal, 10)
                
                ScrollView {
                    VStack (alignment: .leading) {
                        //Balance View
                        TotalBalance
                        
                        
                        Text("Hot Assets")
                            .font(.custom("Urbanist-Bold", size: 24))
                            .foregroundColor(Color("titleColor"))
                            .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 0))
                        // Top Coin ScrollView
                        TopCoinView
                        
                        HStack {
                            Text("My Portfolio")
                                .font(.custom("Urbanist-Bold", size: 24))
                                .foregroundColor(Color("titleColor"))
                            .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 0))
                            
                            Spacer()
                            
                            Button(action: {
                                showAddAssetView.toggle()
                                
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 24))
                                    .padding()
                                
                            }
                            .sheet(isPresented: $showAddAssetView) {
                                AddAssetView(HoldingCoinsVM: HoldingCoinsVM)
                            }
                            
                            Button(action: {
                                isEditing.toggle()
                            }) {
                                Text(isEditing ? "Done" : "Edit")
                                    .font(.system(size: 18))
                                    .padding()
                            }
                        }
                        HoldingCoinView
                        
                    }
                }
                
            }.background(Color(red: 0.969, green: 0.969, blue: 0.98).edgesIgnoringSafeArea(.all))
        }.navigationTitle("Dashboard")
            .sheet(isPresented: $showEditHoldingValueSheet) {
                EditHoldingValueView(coinId: selectedCoinId, newValue: $newHoldingValue) { value in
                    if let coinId = selectedCoinId, let doubleValue = Double(value) {
                        HoldingCoinsVM.updateHoldingValue(forCoinId: coinId, newValue: doubleValue)
                    }
                    showEditHoldingValueSheet = false
                }
            }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(TopCoinsVM: CoinDetailViewModel())
    }
}

extension DashboardView {
    private var TotalBalance: some View {
        ZStack (alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(red: 1, green: 0.604, blue: 0.698))
                .frame(width: UIScreen.main.bounds.width - 30, height: 160)
                .overlay(
                    ZStack {
                        Image("assetShadow")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 320)
                            .position(x: 330, y: 150)
                        Image("asset")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 190)
                            .position(x: 320, y: 110)
                        .clipped()
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
            
            VStack (alignment: .leading) {
                Text("Total Balance").font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color.white)
                    .padding(.init(top: 20, leading: 20, bottom: 1, trailing: 0))
                
                HStack (alignment: .bottom) {
                    Text("$")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(Color.white)
                    Text(HoldingCoinsVM.totalBalance.asCurrencyWith2Decimals().dropFirst()).font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color.white)
                        .offset(x: -6)
                }
                .padding(.init(top: 0, leading: 20, bottom: 5, trailing: 0))
                
                HStack (alignment: .center) {
                    Image(systemName: "arrow.up.right")
                        .foregroundColor(Color("winColor"))
                        .background(
                            Color.white.frame(width: 25, height: 25)
                                .cornerRadius(10)
                        )
                    
                    Text("Weekly Profit:").font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.white)
                        .padding(.leading, 5)
                    
                    Text("+2.5%")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color("winColor"))
                }.padding(.leading, 23)
            }
        }.padding(.all, 15)
    }
    
    private var TopCoinView: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack (spacing: 16){
                ForEach (TopCoinsVM.coins) { coin in
                    NavigationLink (destination: AssetDetailView(coin: coin, CoinChartVM: CoinChartViewModel(coinId: coin.id)))  {
                        AssetsColumnView(coin: coin)
                            .listRowInsets(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
                    }
                }
            }
            .padding()
            .onAppear {
                TopCoinsVM.fetchCoins()
            }
        }
    }
    
    private var HoldingCoinView: some View {
        VStack(spacing: 16) {
            ScrollView (.horizontal, showsIndicators: false) {
                ForEach(HoldingCoinsVM.coins) { coin in
                    HStack {
                        NavigationLink(destination: AssetDetailView(coin: coin, CoinChartVM: CoinChartViewModel(coinId: coin.id))) {
                            AssetSummary(coin: coin)
                                .listRowInsets(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
                        }
                        
                        if isEditing {
                            Button(action: {
                                selectedCoinId = coin.id
                                newHoldingValue = coin.currentHoldings?.description ?? ""
                                showEditHoldingValueSheet.toggle()
                            }) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                                    .padding()
                            }
                            
                            Button(action: {
                                HoldingCoinsVM.deleteCoin(withId: coin.id)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                    .padding()
                            }
                        }
                    }
                    .offset(x: isEditing ? -130 : 0)
                    .animation(.easeInOut)
                }
            }
        }
        .listStyle(PlainListStyle())
        .scrollDisabled(false)
        .padding()
        .onAppear {
            HoldingCoinsVM.fetchCoins()
        }
    }
}
