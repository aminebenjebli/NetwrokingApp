//
//  CoinsViewModel.swift
//  Networking
//
//  Created by AmineBj on 1/16/25.
//

import Foundation
class CoinsViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var coinPrices: [String: Double] = [:] // Store prices by coin ID
    
    private let service = CoinDataService()
    
    init() {
        fetchCoins()
    }
    
    func fetchCoins() {
        service.fetchCoins { coins in
            DispatchQueue.main.async {
                self.coins = coins
                self.fetchAllPrices()
            }
        }
    }
    
    func fetchAllPrices() {
        let coinIds = coins.map { $0.id }
        
        service.fetchPrices(coinIds: coinIds) { prices in
            DispatchQueue.main.async {
                self.coinPrices = prices
            }
        }
    }
}
