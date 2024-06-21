//
//  CoinChartViewModel.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/24/24.
//

import Foundation

class OHLCViewModel: ObservableObject {
    @Published var ohlcData: [OHLC] = []
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = .shared) {
        self.networkService = networkService
    }
    
    func fetchOHLC(for id: String, days: Int, currency: String) {
        let urlString = "https://api.coingecko.com/api/v3/coins/\(id)/ohlc?vs_currency=\(currency)&days=\(days)"
        networkService.fetchData(from: urlString) { (result: Result<[OHLC], NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.ohlcData = data
                case .failure(let error):
                    print("Error fetching OHLC data: \(error)")
                }
            }
        }
    }
}

