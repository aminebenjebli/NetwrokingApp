//
//  Animation.swift
//  Networking
//
//  Created by AmineBj on 11/7/25.
//

import SwiftUI

struct AnimatedSplashScreenView: View {
    @State private var isActive = false
    @State private var rotationAngle = 0.0
    @State private var scale = 0.5
    @State private var opacity = 0.0
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                // Adaptive background based on color scheme
                if colorScheme == .dark {
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.05, green: 0.05, blue: 0.15),
                            Color(red: 0.15, green: 0.15, blue: 0.3)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                } else {
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.2, green: 0.4, blue: 0.8),
                            Color(red: 0.4, green: 0.6, blue: 0.9)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                }
                
                VStack(spacing: 30) {
                    // Animated crypto coins
                    ZStack {
                        // Background circle
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .frame(width: 150, height: 150)
                        
                        // Rotating coin icon
                        Image(systemName: "bitcoinsign.circle.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.yellow, .orange],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .rotationEffect(.degrees(rotationAngle))
                            .shadow(color: .yellow.opacity(0.5), radius: 20)
                    }
                    
                    VStack(spacing: 10) {
                        Text("Crypto Tracker")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("Your Gateway to Crypto Prices")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    // Animated dots loader
                    HStack(spacing: 8) {
                        ForEach(0..<3) { index in
                            Circle()
                                .fill(Color.white)
                                .frame(width: 10, height: 10)
                                .scaleEffect(scale)
                                .animation(
                                    Animation
                                        .easeInOut(duration: 0.6)
                                        .repeatForever()
                                        .delay(Double(index) * 0.2),
                                    value: scale
                                )
                        }
                    }
                    .padding(.top, 20)
                }
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear {
                    // Entry animation
                    withAnimation(.easeOut(duration: 0.8)) {
                        scale = 1.0
                        opacity = 1.0
                    }
                    
                    // Continuous rotation
                    withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: false)) {
                        rotationAngle = 360
                    }
                    
                    // Dots animation
                    withAnimation(.easeInOut(duration: 0.6).repeatForever()) {
                        scale = 1.2
                    }
                    
                    // Navigate after 5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            opacity = 0.0
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AnimatedSplashScreenView()
}
