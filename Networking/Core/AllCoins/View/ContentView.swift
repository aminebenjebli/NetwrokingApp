//
//  ContentView.swift
//  Networking
//
//  Created by AmineBj on 1/16/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var viewModel = CoinsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.coins) { coin in
                HStack {
                    VStack(alignment: .leading) {
                        Text(coin.name)
                            .font(.headline)
                        Text(coin.symbol.uppercased())
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    if let price = viewModel.coinPrices[coin.id] {
                        Text("$\(price, specifier: "%.2f")")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    } else {
                        ProgressView()
                    }
                }
            }
        }
        .navigationTitle("Crypto Prices")
    }
}


#Preview {
    ContentView()
}
