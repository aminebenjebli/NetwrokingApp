# Networking (Crypto Prices)

Lightweight SwiftUI app that fetches top crypto coins and USD prices from CoinGecko and displays them in a simple list.

## Key files
- App entry: [`NetworkingApp`](Networking/NetworkingApp.swift) — [Networking/NetworkingApp.swift](Networking/NetworkingApp.swift)  
- UI: [`ContentView`](Networking/Core/AllCoins/View/ContentView.swift) — [Networking/Core/AllCoins/View/ContentView.swift](Networking/Core/AllCoins/View/ContentView.swift)  
- View model: [`CoinsViewModel`](Networking/Core/AllCoins/ViewModel/CoinsViewModel.swift) — [Networking/Core/AllCoins/ViewModel/CoinsViewModel.swift](Networking/Core/AllCoins/ViewModel/CoinsViewModel.swift)  
- Network service: [`CoinDataService`](Networking/Core/AllCoins/Service/CoinDataService.swift) — [Networking/Core/AllCoins/Service/CoinDataService.swift](Networking/Core/AllCoins/Service/CoinDataService.swift)  
- Model: [`Coin`](Networking/Core/AllCoins/Model/Coin.swift) — [Networking/Core/AllCoins/Model/Coin.swift](Networking/Core/AllCoins/Model/Coin.swift)  
- Xcode project: [Networking.xcodeproj/project.pbxproj](Networking.xcodeproj/project.pbxproj)

## Overview
- Fetches a list of top 20 coins (market cap desc) via CoinGecko markets endpoint.
- Fetches current USD prices using CoinGecko simple price endpoint (single or batch).
- Displays coin name, symbol and current USD price; shows a ProgressView while price loads.

## API endpoints used
- Coins list: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false&price_change_percentage=24h&locale=en  
- Prices: https://api.coingecko.com/api/v3/simple/price?ids={ids}&vs_currencies=usd

## Architecture
- MVVM-like:
  - UI reads observable state from [`CoinsViewModel`](Networking/Core/AllCoins/ViewModel/CoinsViewModel.swift).
  - Networking encapsulated in [`CoinDataService`](Networking/Core/AllCoins/Service/CoinDataService.swift).
  - Domain model in [`Coin`](Networking/Core/AllCoins/Model/Coin.swift).

## Build & run
1. Open Xcode and open the project: `Networking.xcodeproj`.  
2. Select the `Networking` target and an iOS simulator or device (deployment target 18.2).  
3. Build and Run (Cmd+R).

Alternatively use xcodebuild:
```sh
xcodebuild -project [Networking.xcodeproj](http://_vscodecontentref_/0) -scheme Networking -configuration Debug -sdk iphonesimulator build
