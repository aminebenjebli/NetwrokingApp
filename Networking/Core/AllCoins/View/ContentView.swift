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
        List{
            ForEach(viewModel.coins) { coin in
                Text(coin.name)
            }
        }
    }
}


#Preview {
    ContentView()
}
