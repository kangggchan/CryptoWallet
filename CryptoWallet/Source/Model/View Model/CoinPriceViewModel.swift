//
//  CoinPriceViewModel.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/24/24.
//

import Foundation

class CoinPriceViewModel: ObservableObject {
    @Published var coinPrices: [CoinPrice] = []
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func fetchCoinPrices(for ids: [String], currency: String) {
        let idsString = ids.joined(separator: ",")
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(idsString)&vs_currencies=\(currency)"
        networkService.fetchData(from: urlString) { (result: Result<[String: [String: Double]], NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.coinPrices = data.map { CoinPrice(id: $0.key, price: $0.value[currency] ?? 0) }
                case .failure(let error):
                    print("Error fetching coin prices: \(error)")
                }
            }
        }
    }
}

