//
//  RouletteView.swift
//  wwdc-2023
//
//  Created by Roli Bernanda on 12/04/23.
//

import SwiftUI
import Foundation

struct RouletteView: View {
    
    // Bet State
    @StateObject var state = RouletteViewModel.shared
    
    private func bankruptcyView() -> some View {
        Group {
            if state.bankrupt {
                Text("Bankrupt")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            } else {
                EmptyView()
            }
        }
        
    }
    
    private func betButtonsView() -> some View {
        HStack {
            BetButton(betAmount: state.redBet.formatted(),
                      betAction: { state.onBet(.RED) },
                      backgroundColor: .primaryColor, betPayout: "2x")
            
            BetButton(betAmount: state.blackBet.formatted(),
                      betAction: { state.onBet(.BLACK) },
                      backgroundColor: .lightBlack, betPayout: "2x")
            
            BetButton(betAmount: state.greenBet.formatted(),
                      betAction: { state.onBet(.GREEN) },
                      backgroundColor: .lightGreen, betPayout: "18x")
        }
    }
    
    private func bettingAreaView() -> some View {
        VStack(spacing: 8) {
            HStack {
                Spacer()
                Button(action: {
                    state.isHowToPlayVisible = true
                }) {
                    Image(systemName: "questionmark.bubble")
                        .foregroundColor(.borderColor)
                        .font(.system(size: 28, weight: .thin))
                }
            }
            
            HStack {
                Text("Balance")
                Spacer()
                Text("$ \(state.balance.formatted())")
            }
            
            HStack {
                Text("Value Bet")
                Spacer()
                Text("$ \(String(format: "%.2f", state.valueBet))").foregroundColor(.primaryColor)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .font(.system(size: 24, weight: .thin))
    }
    
    private func betAmountView() -> some View {
        ZStack {
            HStack {
                Text("$").foregroundColor(.yellow)
                TextField("Bet Amount", text: $state.betAmount)
                    .keyboardType(.numberPad)
                    .onChange(of: state.betAmount) { value in
                        let intBalance = Int(state.balance)
                        
                        if state.totalBets == intBalance || state.bankrupt {
                            state.betAmount = ""
                            return
                        }
                        
                        let filtered = value.filter {
                            "0123456789".contains($0)
                        }
                        
                        if filtered != value {
                            state.betAmount = filtered
                        }
                        
                        let intFiltered = Int(filtered) ?? 0
                        
                        let totatCurrentBet = intFiltered + state.totalBets
                        
                        if state.totalBets > intBalance {
                            state.blackBet = 0
                            state.redBet = 0
                            state.greenBet = 0
                        } else if totatCurrentBet > intBalance {
                            state.betAmount = String(intBalance - state.totalBets)
                        }
                        
                    }
                    .disabled(state.bankrupt)
            }
            .padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white, lineWidth: 0.5)
        )
        .cornerRadius(8)
    }
    
    private func gameControlsView() -> some View {
        VStack() {
            HStack(spacing: 8) {
                betAmountView()
                Button(action: {
                    withAnimation(.easeOut(duration: 0.3)) {
                        state.spinWheel()
                    }
                }, label: {
                    HStack(spacing: 4) {
                        Image(systemName: "circle.circle")
                            .foregroundColor(.white)
                        Text("Spin")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                })
                .frame(width: UIScreen.main.bounds.width * 0.3 * 0.25)
                .background(Color.primaryColor)
                .opacity(state.disabledButton ? 0.5 : 1)
                .cornerRadius(8)
                .disabled(state.disabledButton)
            }
            .padding(.horizontal, 8)
            
            HStack(spacing: 8) {
                Button(action: {
                    state.clearBetState()
                }, label: {
                    HStack(spacing: 4) {
                        Image(systemName: "clear")
                        Text("Clear")
                    }
                    .padding()
                    .foregroundColor(.white)
                    
                })
                .frame(maxWidth: .infinity)
                .cornerRadius(8)
                
                Button(action: {
                    state.restart()
                }, label: {
                    HStack(spacing: 4) {
                        Image(systemName: "restart")
                        Text("Restart")
                    }
                    .padding()
                    .foregroundColor(.white)
                })
                .frame(maxWidth: .infinity)
                .cornerRadius(8)
            }
            .font(.system(size: 16, weight: .thin))
            .padding(.all, 8)
        }
        .padding(.horizontal, 8)
    }
    
    private func betHistoryView() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Bet History")
                .padding(.horizontal)
                .padding(.top)
                .font(.system(size: 20, weight: .thin))
            
            List {
                if state.betHistory.isEmpty {
                    Text("No data").listRowBackground(Color.clear).listRowSeparator(.hidden)
                } else {
                    ForEach(state.betHistory.reversed(), id: \.self.id) { bet in
                        Text("$ \(bet.payout)")
                            .foregroundColor( bet.payout >= 0 ? .lightGreen : .primaryColor)
                            .listRowBackground(Color.clear)
                            .onAppear {
                                let animation = Animation.easeOut(duration: 0.3).delay(0.05)
                                withAnimation(animation) {}
                            }
                    }
                }
            }
            .listStyle(.plain)
            .font(.system(size: 20, weight: .thin))
        }
    }
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 20) {
                bettingAreaView()
                    .background(Color.lightBlack)
                    .cornerRadius(8)
                    .frame(width: .infinity, height: UIScreen.main.bounds.width * 0.12)
                
                VStack {
                    Spacer()
                    betButtonsView()
                    Spacer()
                    gameControlsView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.lightBlack).cornerRadius(8)
                
                betHistoryView()
                    .background(Color.lightBlack)
                    .cornerRadius(8)
                    .frame(width: .infinity, height: UIScreen.main.bounds.width * 0.2)
            }
            .frame(width: UIScreen.main.bounds.width * 0.3)
            
            VStack {
                ZStack(alignment: .top) {
                    ZStack(alignment: .center) {
                        WheelView(data: (0..<options.count).map { _ in Double(100 / options.count) }, colors: WHEEL_COLORS)
                            .rotationEffect(.degrees(state.degree))
                        
                        WheelBolt()
                            .rotationEffect(.degrees(state.degree))
                        
                    }
                    WheelPointer(pointerColor: Color.accentColor).offset(x: 0, y: -25)
                }
                .padding(36)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.lightBlack)
            .cornerRadius(8)
        }
        .padding(36)
        .sheet(isPresented: $state.bankrupt) {
            BankruptModal(action: {
                state.restart()
            })
        }
        .sheet(isPresented: $state.isHowToPlayVisible) {
            HowToPlayModal()
        }
    }
}


