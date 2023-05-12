//
//  File.swift
//  
//
//  Created by Roli Bernanda on 15/04/23.
//

import Foundation
import SwiftUI

enum RouletteColor: Int {
    case GREEN = 0
    case RED = 1
    case BLACK = 2
}

let WHEEL_COLORS: [Color] = [
    .lightGreen, .primaryColor, .lightBlack, .primaryColor, .lightBlack, .primaryColor, .lightBlack, .primaryColor, .lightBlack, .primaryColor, .lightBlack, .primaryColor, .lightBlack , .primaryColor, .lightBlack, .primaryColor, .lightBlack, .primaryColor, .lightBlack
]

let options = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18"]

struct BetHistory {
    var id: UUID
    var payout: Int
    var status: String {
        didSet {
            if status != "win" && status != "lose" && status != "tie" {
                status = oldValue
            }
        }
    }
}

public class RouletteViewModel: ObservableObject {
    static let shared = RouletteViewModel()
    
    @Published var balance: Double = 100
    @Published var redBet: Int = 0
    @Published var blackBet: Int = 0
    @Published var greenBet: Int = 0
    @Published var betAmount: String = ""
    @Published var selectedBetState: RouletteColor? = nil
    @Published var bankrupt: Bool = false
    @Published var betHistory = [BetHistory]()
    
    @Published var isHowToPlayVisible: Bool = true
    @Published var disabledButton: Bool = true
    @Published var degree = 0.0
    @Published var pendingRequestWorkItem: DispatchWorkItem?
    
    let animDuration: Double = 1
    let animation: Animation = Animation.spring(response: 0.5, dampingFraction: 0.6)
    
    let payouts = (red: 1.0, black: 1.0, green: 17.0)
    let probabilities = (red: 9.0/19.0, black: 9.0/19.0, green: 1.0/19.0)
    
    public var totalBets: Int {
        get {
            return redBet + blackBet + greenBet
        }
    }
    
    var redPayout: Double {
        get {
            let netRedBet = Double(redBet) * payouts.red - Double(totalBets - redBet)
            return netRedBet * probabilities.red
        }
    }
    
    var blackPayout: Double {
        get {
            let netBlackBet = Double(blackBet) * payouts.black - Double(totalBets - blackBet)
            return netBlackBet * probabilities.black
        }
    }
    
    var greenPayout: Double {
        get {
            let netGreenBet = Double(greenBet) * payouts.green - Double(totalBets - greenBet)
            return netGreenBet * probabilities.green
        }
    }
    
    var valueBet: Double {
        get {
            return redPayout + blackPayout + greenPayout
        }
    }
    
    
    func addBetHistory(payout: Int, status: String) {
        let newBet = BetHistory(id: UUID(), payout: payout, status: status)
        betHistory.append(newBet)
    }
    
    func onSpinEnd(index: Int) {
        
        var payout: Double = 0
        
        // Red is odd, Black is even, Green is 0
        if index == 0 {
            payout += 18 * Double(self.greenBet)
        } else if index % 2 == 0 {
            payout += 2 * Double(self.blackBet)
        } else {
            payout += 2 * Double(self.redBet)
        }
        
        self.addBetHistory(payout: Int(payout) - self.totalBets, status: Int(payout) > self.totalBets ? "win" : "lose")
        self.balance += payout
        self.bankrupt = self.balance <= 0
        disabledButton = self.totalBets > Int(self.balance)
    }
    
    func getWheelStopDegree() -> Double {
        let index = options.count - Int.random(in: 0..<options.count) - 1;
        //        let index = -1
        /*
         itemRange - Each items degree range (For 4, each will have 360 / 4 = 90 degrees)
         indexDegree - No. of 90 degrees to reach i item
         freeRange - Flexible degree in the item, so the pointer doesn't always point start of the item
         freeSpins - No. of spins before it goes to selected item index
         finalDegree - Final exact degree to spin and stop in the index
         */
        let itemRange = 360 / options.count;
        let indexDegree = itemRange * index;
        let freeRange = Int.random(in: 0...itemRange);
        let freeSpins = (2...20).map({ return $0 * 360 }).randomElement()!
        let finalDegree = freeSpins + indexDegree + freeRange;
        return Double(finalDegree);
    }
    
    func spinWheel() {
        if self.bankrupt {
            return
        }
        self.balance -= Double(self.totalBets)
        disabledButton = true
        withAnimation(animation) {
            degree = Double(360 * Int(degree / 360)) + getWheelStopDegree();
        }
        
        //         Cancel the currently pending item t1
        pendingRequestWorkItem?.cancel()
        let requestWorkItem = DispatchWorkItem {
            let count = options.count
            let distance = self.degree.truncatingRemainder(dividingBy: 360)
            let pointer = floor(distance / (360 / Double(count)))
            self.onSpinEnd(index: count - Int(pointer) - 1)
        }
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + animDuration, execute: requestWorkItem)
    }
    
    func clearBetState() {
        self.betAmount = ""
        self.redBet = 0
        self.blackBet = 0
        self.greenBet = 0
        self.disabledButton = true
    }
    
    func onBet(_ betColor: RouletteColor) {
        var parsedBet = Int(self.betAmount) ?? 0
        let intBalance = Int(self.balance)
        
        if parsedBet > intBalance {
            parsedBet = intBalance
        }
        
        if parsedBet > 0 {
            if betColor == .RED {
                self.redBet += parsedBet
            } else if betColor == .BLACK {
                self.blackBet += parsedBet
            } else if betColor == .GREEN {
                self.greenBet += parsedBet
            }
            self.betAmount = ""
            disabledButton = false
        }
    }
    
    func restart() {
        self.balance = 100
        self.redBet = 0
        self.blackBet = 0
        self.greenBet = 0
        self.betAmount = ""
        self.selectedBetState = nil
        self.bankrupt = false
        self.disabledButton = true
    }
    
}
