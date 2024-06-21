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
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchCoins()
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
            
//           Fetch coin data from CoinGecko API based on the IDs
//            guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?ids=\(coinIDQuery)&vs_currency=usd&order=market_cap_desc&sparkline=false&price_change_percentage=24h") else {
//                print("Invalid URL")
//                return
//            }
            
            

            
            URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: [Coin].self, decoder: JSONDecoder())
                .sink { [weak self] completion in
                    if case .failure(let error) = completion {
                        print("Error fetching data: \(error)")
                    }
                } receiveValue: { [weak self] (fetchedCoins) in
                    // Populate currentHoldings property based on holding values from the JSON file
                    var coinsWithHoldings = fetchedCoins
                    for holdingInfo in holdingInfos {
                        if let index = coinsWithHoldings.firstIndex(where: { $0.id == holdingInfo.id }) {
                            coinsWithHoldings[index].currentHoldings = holdingInfo.holdingValue
                        }
                    }
                    self?.coins = coinsWithHoldings
                }
                .store(in: &cancellables)
            
        } catch {
            print("Error decoding holding_info.json: \(error)")
        }
    }
}

