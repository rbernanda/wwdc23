import SwiftUI

@main
struct MyApp: App {
    @State private var selectedTab: String = "Home"
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                HomeView(tab: $selectedTab)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.darkBlack.ignoresSafeArea())
                    .foregroundColor(.white)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag("Home")
                
                ValueBetView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.darkBlack.ignoresSafeArea())
                    .foregroundColor(.white)
                    .tabItem {
                        Label("Value Bet", systemImage: "doc")
                    }
                    .tag("ValueBet")
                
                RouletteView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.darkBlack.ignoresSafeArea())
                    .foregroundColor(.white)
                    .tabItem {
                        Label("Roulette", systemImage: "gamecontroller")
                            .background(Color.blue)
                    }
                    .tag("Roulette")
            }
            .preferredColorScheme(.dark)
        }
    }
}
