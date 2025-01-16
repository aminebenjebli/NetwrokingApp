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
     
    init() {
        fetchPrice(coin: "ethereum")
    }
    
    func fetchPrice(coin: String) {
        // Construct the URL string for the API request using the provided coin parameter.
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        
        // Convert the string URL to a URL object. If it fails, exit the function.
        guard let url = URL(string: urlString) else { return }
        
        print("fetching price..")
        
        // Create a data task to fetch data from the specified URL.
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            print("Did receive data \(data)")
            
            // Ensure that data is not nil; if it is, exit the function.
            guard let data = data else { return }
            
            // Attempt to deserialize the received JSON data into a Swift dictionary.
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            
            print(jsonObject)
            
            // Access the value associated with the coin key; expect it to be a dictionary of type [String: Double].
            guard let value = jsonObject[coin] as? [String: Double] else {
                print("Failed to parse value") // Log an error message if parsing fails.
                return
            }
            
            // Retrieve the price in USD from the value dictionary. If it doesn't exist, exit the function.
            guard let price = value["usd"] else { return }
            
            // Update UI-related properties on the main thread since UI updates must occur on this thread.
            DispatchQueue.main.async {
                self.coin = coin.capitalized
                self.price = "$\(price)"
            }
            
        }.resume() // Start the data task.
        
        print("Did reach end of function")
    }

}
