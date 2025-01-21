//
//  CoinsViewModel.swift
//  Networking
//
//  Created by AmineBj on 1/16/25.
//

import Foundation
class CoinsViewModel : ObservableObject {
    @Published var coins = [Coin]()
    
    private let service = CoinDataService()
     
    init() {
        fetchCoins()
    }
    func fetchCoins() {
        service.fetchCoins {coins in
            DispatchQueue.main.async {
                self.coins = coins
            }
        }
    }
}
