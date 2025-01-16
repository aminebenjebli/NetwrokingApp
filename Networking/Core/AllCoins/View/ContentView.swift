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
        VStack  {
           
            Text("\(viewModel.coin): \(viewModel.price)")
            
        }	
        .padding()
    }
}


#Preview {
    ContentView()
}
