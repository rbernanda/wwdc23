//
//  SwiftUIView.swift
//  
//
//  Created by Roli Bernanda on 19/04/23.
//

import SwiftUI

public class ValueBetViewModel: ObservableObject {
    @Published var stake = ""
    @Published var odds = ""
    @Published var probability = ""
    
    public func isValidProbs() -> Bool {
        let doubledProbs = Double(probability) ?? 0
        return doubledProbs >= 0.0 && doubledProbs <= 100.0
    }
    
    public var expectedValue: Double {
        
        guard !stake.isEmpty, !odds.isEmpty, !probability.isEmpty else {
            return 0.0
        }
        
        let doubledStake = Double(stake) ?? 0
        let doubledOdds = Double(odds) ?? 0
        let doubledProbs = Double(probability) ?? 0
        
        guard isValidProbs() else {
            return 0.0
        }
        
        let winPayout = doubledOdds * doubledStake
        let loseAmount = doubledStake
        let winProbability = doubledProbs / 100.0
        let loseProbability = 1.0 - winProbability
        let valueBet = (winProbability * winPayout) - (loseProbability * loseAmount)
        return valueBet
    }
}
