//
//  Coin.swift
//  Networking
//
//  Created by AmineBj on 1/21/25.
//

import Foundation
struct Coin: Decodable,Identifiable {
    let id : String
    let symbol : String
    let name : String
    var currentPrice: Double?
//    let marketCapRank: Int
}
    
