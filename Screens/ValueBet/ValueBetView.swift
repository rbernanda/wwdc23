//
//  ValueBetView.swift
//  wwdc-2023
//
//  Created by Roli Bernanda on 14/04/23.
//

import SwiftUI

struct ValueBetView: View {
    @StateObject var state = ValueBetViewModel()
    
    private func betAmountView(prefix: String, value: Binding<String>, placeholder: String, label: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
            ZStack {
                HStack {
                    Image(systemName: prefix).foregroundColor(.yellow)
                    TextField(placeholder, text: value)
                        .keyboardType(.numberPad)
                }
                .padding()
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.borderColor, lineWidth: 1)
            )
        }
        .cornerRadius(8)
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    var body: some View {
        HStack(spacing: 20) {
            ZStack(alignment: .trailing) {
                Rectangle()
                        .fill(Color.lightBlack)
                        .frame(width: UIScreen.main.bounds.width * 0.4)
                        .frame(height: UIScreen.main.bounds.height * 0.7)
                        .cornerRadius(20)
                
                VStack(alignment: .leading) {
                    Spacer()
                    betAmountView(prefix: "dollarsign", value: $state.stake, placeholder: "10", label: "Stake")
                    betAmountView(prefix: "arrow.up.right", value: $state.odds, placeholder: "0.9", label: "Decimal odds given by a Bookmaker")
                    betAmountView(prefix: "arrowtriangle.up.square", value: $state.probability, placeholder: "0% to 100%", label: "True probability calculated by you")
                    
                    Spacer()
                    
                    if !state.stake.isEmpty && !state.odds.isEmpty && !state.probability.isEmpty && state.isValidProbs() {
                        Text("For every bet of $\(state.stake), you can expect to make $\(String(format: "%.2f", state.expectedValue)) in average")
                            .foregroundColor(.borderColor)
                            .padding(.horizontal)
                    }
                        
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.softGreen)
                            .frame(height: 40)
                        HStack {
                            Text("Value Bet")
                            Spacer()
                            Text("$\(String(format: "%.2f", state.expectedValue))")
                        }.padding(.horizontal)
                    }

                }
                .frame(width: UIScreen.main.bounds.width * 0.5 * 0.7)
                .frame(height: UIScreen.main.bounds.height * 0.5)
                .background(Color.darkBlack)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.borderColor, lineWidth: 1)
                )
                .offset(x: 50, y: 0)
                .zIndex(1)
            }
            .frame(width: UIScreen.main.bounds.width * 0.5)
            
            VStack(alignment: .leading, spacing: 16 ) {
                Spacer()
                Text("How to calculate value bet?").font(.largeTitle).bold()
                Text("Enter the odds & stake and the calculator will do the rest")
                    .font(.title3).foregroundColor(Color.borderColor)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("1st Step").foregroundColor(Color.borderColor)
                    Text("Enter the odds")
                }
                .font(.title3)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("2nd Step").foregroundColor(Color.borderColor)
                    Text("Insert the relevant information")
                }
                .font(.title3)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("3rd Step").foregroundColor(Color.borderColor)
                    Text("Check Your Value Bet")
                }
                .font(.title3)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(8)
            .padding(.horizontal)
        }
        
    }
}

struct ValueBetView_Previews: PreviewProvider {
    static var previews: some View {
        ValueBetView()
    }
}
