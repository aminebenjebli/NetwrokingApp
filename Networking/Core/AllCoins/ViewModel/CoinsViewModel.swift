//
//  CoinsViewModel.swift
//  Networking
//
//  Created by AmineBj on 1/16/25.
//

import Foundation
class CoinsViewModel : ObservableObject {
    @Published var coin = ""
    @Published var price = ""
    @Published var errorMessage: String?
    
    private let service = CoinDataService()
     
    init() {
        fetchPrice(coin: "coin")
    }
    
    func fetchPrice(coin: String) {
        service.fetchPrice(coin: coin) {priceFromService in
            DispatchQueue.main.async {
                self.price = "\(priceFromService)"
                self.coin = coin
            }
            
        }
    }
}
