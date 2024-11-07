//
//  CoinChartViewModel.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/24/24.
//

import Foundation
import Combine

class CoinChartViewModel: ObservableObject {
    @Published var ohlcData: [OHLC] = []
    public var coinId: String
    
    
    private let networkService: NetworkService
    private var timer: AnyCancellable?
    
    init(coinId: String, networkService: NetworkService = .shared) {
        self.coinId = coinId
        self.networkService = networkService
        startTimer()
    }
    
    deinit {
            timer?.cancel()
        }
    
    func fetchOHLC(for id: String, timeframe: String) {
        
        let baseURL = URL(string: "https://api.coingecko.com/api/v3/coins/\(id)/ohlc")!
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "days", value: timeframe)
        ]
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        let headers = [
            "accept": "application/json",
            "x-cg-demo-api-key": "CG-g3RgFPvsLQBoDSjxBZ9HHwwc"
        ]
        
        //let url = "https://api.coingecko.com/api/v3/coins/\(id)/ohlc?vs_currency=usd&days=\(timeframe)"
        
        networkService.fetchData(from: components.url!.absoluteString, headers: headers) { (result: Result<[OHLC], NetworkError>) in
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
    
    private func startTimer() {
        timer = Timer.publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.fetchOHLC(for: self.coinId, timeframe: "7")
            }
    }
}


