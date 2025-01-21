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
    func fetchPrice(coin: String, completion: @escaping(Double) ->  Void) {
        // Construct the URL string for the API request using the provided coin parameter.
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        // Convert the string URL to a URL object. If it fails, exit the function.
        guard let url = URL(string: urlString) else { return }
        
        
        // Create a data task to fetch data from the specified URL.
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DEBUG : Failed with error \(error.localizedDescription)")
                //self.errorMessage = error.localizedDescription
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                //self.errorMessage = "BAD HTTP Response."
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                //self.errorMessage = "Failed to fetch with status code \(httpResponse.statusCode)"
                return
            }
            
            // Ensure that data is not nil; if it is, exit the function.
            guard let data = data else { return }
            
            // Attempt to deserialize the received JSON data into a Swift dictionary.
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            
            
            // Access the value associated with the coin key; expect it to be a dictionary of type [String: Double].
            guard let value = jsonObject[coin] as? [String: Double] else {
                print("Failed to parse value")
                return
            }
            
            // Retrieve the price in USD from the value dictionary. If it doesn't exist, exit the function.
            guard let price = value["usd"] else { return }
            // Update UI-related properties on the main thread since UI updates must occur on this thread.
//                self.coin = coin.capitalized
//                self.price = "$\(price)"
            print("DEBUG: price in service is \(price)")
            completion(price)
        }.resume() // Start the data task.
    }
}
