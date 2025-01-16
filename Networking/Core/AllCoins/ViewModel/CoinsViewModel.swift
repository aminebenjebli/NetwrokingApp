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
        fetchPrice()
    }
    
    func fetchPrice(){
      let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd" //convert string url to object url
        guard let url = URL(string: urlString) else { return }
        print("fetching price..")
        URLSession.shared.dataTask(with: url) { data , response , error in
            print("Did receive data \(data)")
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else { return }//Swift dictionnary
            
            guard let value = jsonObject["bitcoin"] as? [String: Int] else { return }//Swift dictionnary
            guard let price = value["usd"] else { return }
            DispatchQueue.main.async {
                self.coin = "Bitcoin"
                self.price = "$\(price)"
            }
        }.resume()
        print("Did reach end of function")
    }
}
