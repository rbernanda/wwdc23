//
//  File.swift
//  
//
//  Created by Roli Bernanda on 18/04/23.
//

import Foundation
import SwiftUI

let slides: [[String]] = [
    // 0
    ["To beat bookmakers, we need to understand their business model. Bookmakers make money by accepting bets on a market and pricing it in a way that gives them an edge over bettors", "This edge is often referred to as the 'margin' or 'vig', which can be thought of as a fee that they charge for taking bets"],
    
    // 1
    ["For example, if a bookmakers sets the odds of a particular team winning a match at 2.00, it means they expect that team to win 50% of the time", "However, they may set the odds at 1.90 to attract bets on both sides, which would give them a margin of 5% (1 / 1.90 - 1 = 0.0526)", "This means that for every $100 bet on either side of the match, the bookmaker expects to earn $5 in profit on average. So, if you're planning to place a bet, keep in mind that the odds are designed to make the bookmakers money over the long run"],
    
    // 2
    ["Now that we know how bookmakers make money, the question is how can we beat them?",
     "Fortunately, bookmakers are not infallible and make mistakes, and their advantage can be beaten", "Let me introduce you to the concept of value betting, which means placing bets only when your chances of winning are higher than the odds offered by the bookmakers"],
    
    // 3
    ["Do you get the idea?", "We use their own spells against them! If we are able to do it consistently and accurately we will make profit in the long run.", "But, to do this, we need to have a deep understanding of the teams, players, and other factors that can affect the outcome of a match. Additionally, having a disciplined approach to bankroll management, to minimize risk and maximize profit on each game", "Is this a difficult and risky career choice, in your opinion?"],
    
    // 4
    
    ["I have created a value bet calculator for you. To keep it simple, let's assume that you already have the true probability of the game based on your research"],
    
    // 5
    ["However, this doesn’t work for casino games like roulette or slots. Where the odds are always stacked against you no matter what you do", "The odds in casino games are designed to favor the house, so players are at a disadvantage from the start", "Their people can make mistakes, but their machines don't"],
    
    // 6
    ["Here is a roulette game that demonstrates and automatically calculates the value of each bet you place", "Have fun and gambling responsible!"]
]

public class HomeViewState: ObservableObject {
    static let shared = HomeViewState()
    
    @Published var step: Int = 0
    
    @Published var subTitle: String = ""
    let finalSubtitle: String = "...  Can we?"
    
    public func next() {
        step = step + 1
    }
    
    public func prev() {
        step = step - 1
    }
}
