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
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }else{
                Text("\(viewModel.coin) : \(viewModel.price)")
            }           
            
        }	
        .padding()
    }
}


#Preview {
    ContentView()
}
