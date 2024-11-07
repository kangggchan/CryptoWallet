//
//  HoldingCoinModel.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/16/24.
//

import Foundation
import Combine

struct HoldingCoins: Codable {
    let id: String
    let image: String
    let holdingValue: Double
}

class HoldingCoinModel: ObservableObject {
    
    @Published var coins: [Coin] = []
    
    private let networkService: NetworkService
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    var totalBalance: Double {
        coins.reduce(0) { $0 + (($1.currentHoldings ?? 0) * $1.currentPrice) }
    }
    
    func fetchCoins() {
        // Load holding information from the JSON file
        guard let holdingInfoURL = Bundle.main.url(forResource: "holdingCoins", withExtension: "json") else {
            print("Failed to locate holdingCoins.json")
            return
        }
        
        do {
            let holdingInfoData = try Data(contentsOf: holdingInfoURL)
            let holdingInfos = try JSONDecoder().decode([HoldingCoins].self, from: holdingInfoData)
            
            // Extract coin IDs from the holding information
            let coinIDs = holdingInfos.map { $0.id }
            let coinIDQuery = coinIDs.joined(separator: ",")
            
            
            let baseURL = URL(string: "https://api.coingecko.com/api/v3/coins/markets")!
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: "ids", value: coinIDQuery),
                URLQueryItem(name: "vs_currency", value: "usd"),
                URLQueryItem(name: "order", value: "market_cap_desc"),
                URLQueryItem(name: "sparkline", value: "false"),
                URLQueryItem(name: "price_change_percentage", value: "24h"),
            ]
            components.queryItems = queryItems
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            let headers = [
                "accept": "application/json",
                "x-cg-demo-api-key": "CG-g3RgFPvsLQBoDSjxBZ9HHwwc"
            ]
            
//          Fetch coin data from CoinGecko API based on the IDs
            networkService.fetchData(from: components.url!.absoluteString, headers: headers) { (result: Result<[Coin], NetworkError>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let fetchedCoins):
                        // Map the holding values to the fetched coins
                        self.coins = fetchedCoins.map { coin in
                            var updatedCoin = coin
                            if let holdingInfo = holdingInfos.first(where: { $0.id == coin.id }) {
                                updatedCoin.currentHoldings = holdingInfo.holdingValue
                            }
                            return updatedCoin
                        }
                    case .failure(let error):
                        print("Error fetching coin details: \(error)")
                    }
                }
                
            }
//
        } catch {
            print("Error decoding holding_info.json: \(error)")
        }
    }
    
    func deleteCoin(withId id: String) {
        guard let holdingInfoURL = Bundle.main.url(forResource: "holdingCoins", withExtension: "json") else {
            print("Failed to locate holdingCoins.json")
            return
        }
        
        do {
            var holdingInfos = try JSONDecoder().decode([HoldingCoins].self, from: Data(contentsOf: holdingInfoURL))
            holdingInfos.removeAll { $0.id == id }
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let newData = try encoder.encode(holdingInfos)
            try newData.write(to: holdingInfoURL)
            
            // Update the coins array
            self.coins.removeAll { $0.id == id }
        } catch {
            print("Error updating holding_info.json: \(error)")
        }
    }
    
    
    func addCoin(_ coin: HoldingCoins) {
        guard let holdingInfoURL = Bundle.main.url(forResource: "holdingCoins", withExtension: "json") else {
            print("Failed to locate holdingCoins.json")
            return
        }
        
        do {
            var holdingInfos = try JSONDecoder().decode([HoldingCoins].self, from: Data(contentsOf: holdingInfoURL))
            holdingInfos.append(coin)
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let newData = try encoder.encode(holdingInfos)
            try newData.write(to: holdingInfoURL)
            
            // Fetch the updated coins data
            fetchCoins()
        } catch {
            print("Error updating holding_info.json: \(error)")
        }
    }
    
    func updateHoldingValue(forCoinId id: String, newValue: Double) {
        if let index = coins.firstIndex(where: { $0.id == id }) {
            coins[index].currentHoldings = newValue
            saveCoinsToJSON()
        }
    }
        
    private func saveCoinsToJSON() {
        let holdingCoins = coins.map { HoldingCoins(id: $0.id, image: $0.image, holdingValue: $0.currentHoldings ?? 0) }
        if let jsonData = try? JSONEncoder().encode(holdingCoins) {
            if let jsonURL = Bundle.main.url(forResource: "holdingCoins", withExtension: "json") {
                try? jsonData.write(to: jsonURL)
            }
        }
        
    }
}

