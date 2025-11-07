//
//  CoinDataService.swift
//  Networking
//
//  Created by AmineBj on 1/21/25.
//

import Foundation
public class CoinDataService {
    
    //**********Fetch Coins Function**********
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false&price_change_percentage=24h&locale=en"
    func fetchCoins(completion: @escaping ([Coin]) -> Void){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
           guard let data = data else { return }
            guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else {
                print("Failed to decode coins")
                return
            }
            completion(coins)
            
            
            //print("DEBUG: Coins decoded \(coins)")
        }.resume()
    }
    
    
    //**********Fetch Price Function**********
    func fetchPrice(coin: String, completion: @escaping(Double) -> Void) {
            let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("DEBUG: Failed with error \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
                    print("DEBUG: Failed to fetch with status code \(httpResponse.statusCode)")
                    return
                }
                
                guard let data = data else { return }
                
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                
                guard let value = jsonObject[coin] as? [String: Double] else {
                    print("Failed to parse value")
                    return
                }
                
                guard let price = value["usd"] else { return }
                
                print("DEBUG: price in service is \(price)")
                completion(price)
            }.resume()
        }
        
        // Better: Fetch multiple prices at once
        func fetchPrices(coinIds: [String], completion: @escaping([String: Double]) -> Void) {
            let idsString = coinIds.joined(separator: ",")
            let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(idsString)&vs_currencies=usd"
            
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("DEBUG: Failed with error \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    return
                }
                
                guard let data = data else { return }
                
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                
                var prices: [String: Double] = [:]
                
                for (coinId, value) in jsonObject {
                    if let priceDict = value as? [String: Double],
                       let usdPrice = priceDict["usd"] {
                        prices[coinId] = usdPrice
                    }
                }
                
                completion(prices)
            }.resume()
        }
    }
