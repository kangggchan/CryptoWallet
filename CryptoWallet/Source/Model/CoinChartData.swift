//
//  CoinChartData.swift
//  CryptoWallet
//
//  Created by Khang Bùi Phước on 5/24/24.
//

import Foundation

struct OHLC: Decodable {
    let timestamp: Double
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        timestamp = try container.decode(Double.self)
        open = try container.decode(Double.self)
        high = try container.decode(Double.self)
        low = try container.decode(Double.self)
        close = try container.decode(Double.self)
    }
}
