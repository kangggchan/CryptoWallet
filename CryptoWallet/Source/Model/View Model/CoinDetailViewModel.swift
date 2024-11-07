//
//  allCoinsViewModel.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/15/24.
//

import Foundation



class CoinDetailViewModel: ObservableObject {
    
    @Published var coins: [Coin] = []
    
    private let networkService: NetworkService
        
        
    init(networkService: NetworkService = .shared) {
    
        self.networkService = networkService

    }
    
    
    func fetchCoins() {
//        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=5&page=1&sparkline=false&price_change_percentage=24h") else {
//            print("Invalid URL")
//            return
//        }
        
//        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets")!
//        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//        let queryItems: [URLQueryItem] = [
//          URLQueryItem(name: "vs_currency", value: "usd"),
//          URLQueryItem(name: "order", value: "market_cap_desc"),
//          URLQueryItem(name: "per_page", value: "5"),
//          URLQueryItem(name: "page", value: "1"),
//          URLQueryItem(name: "sparkline", value: "true"),
//          URLQueryItem(name: "price_change_percentage", value: "24h"),
//        ]
//        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
//
//        var request = URLRequest(url: components.url!)
//        request.httpMethod = "GET"
//        request.timeoutInterval = 10
//        request.allHTTPHeaderFields = [
//          "accept": "application/json",
//          "x-cg-demo-api-key": "CG-g3RgFPvsLQBoDSjxBZ9HHwwc"
//        ]
        
        let baseURL = URL(string: "https://api.coingecko.com/api/v3/coins/markets")!
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "order", value: "market_cap_desc"),
            URLQueryItem(name: "per_page", value: "5"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sparkline", value: "true"),
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

                
        networkService.fetchData(from: components.url!.absoluteString, headers: headers) { (result: Result<[Coin], NetworkError>) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let data):
                            self.coins = data
                        case .failure(let error):
                            print("Error fetching coin details: \(error)")
                        }
                    }
                }
    }


}
