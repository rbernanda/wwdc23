//
//  HomeView.swift
//  wwdc-2023
//
//  Created by Roli Bernanda on 12/04/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var state = HomeViewState.shared
    @StateObject var valueBetState = ValueBetViewModel()
    
    @Binding var tab: String
    @State var textOpacity: Double = 0
    
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
        .padding(.vertical, 8)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer()
                        
            if state.step == 0 {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                Text(state.subTitle).font(.system(.body))
                    .onAppear() {
                        typeWriter(finalText: state.finalSubtitle, text: $state.subTitle)
                    }
            }
            VStack(alignment: .leading, spacing: 12) {
                ForEach(slides[state.step], id: \.self) { text in
                    Text("\(text)")
                        .font(.system(size: 24))
                        .foregroundColor(.borderColor)
                        .multilineTextAlignment(.leading)
                        .font(.system(.body))
                        .opacity(textOpacity)
                }
            }
            .onAppear {
                withAnimation(.easeOut(duration: 1)){
                    textOpacity = 1.0
                }
            }
            .onChange(of: state.step) { _ in
                textOpacity = 0
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation(.easeOut(duration: 1)) {
                        textOpacity = 1.0
                    }
                }
            }
            
            if state.step == 4 {
                VStack(alignment: .leading) {
                    betAmountView(prefix: "dollarsign", value: $valueBetState.stake, placeholder: "10", label: "Stake")
                    betAmountView(prefix: "arrow.up.right", value: $valueBetState.odds, placeholder: "0.9", label: "Decimal odds given by a Bookmaker")
                    betAmountView(prefix: "arrowtriangle.up.square", value: $valueBetState.probability, placeholder: "0% to 100%", label: "True probability calculated by you")
                    
                    if !valueBetState.stake.isEmpty && !valueBetState.odds.isEmpty && !valueBetState.probability.isEmpty && valueBetState.isValidProbs() {
                        Text("For every bet of $\(valueBetState.stake), you can expect to make $\(String(format: "%.2f", valueBetState.expectedValue)) in average")
                            .foregroundColor(.borderColor)
                    }
                }
            }

            Spacer()
            HStack() {
                Spacer()
                Button {
                    state.prev()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 24))
                        .foregroundColor(.primaryColor)
                        .padding()
                }
                .opacity(state.step == 0 ? 0 : 1)
                .disabled(state.step == 0)
                
                
                Spacer().frame(width: 110)
                Button {
                    if state.step == slides.count - 1 {
                        tab = "Roulette"
                    } else {
                        state.next()
                    }
                } label: {
                    if state.step == slides.count - 1 {
                        Text("Play Now")
                            .font(.system(size: 24))
                            .padding()
                    } else {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 24))
                            .padding()
                    }
                }
                .foregroundColor(.primaryColor)
                
            }
            .padding(.bottom, 50)


            
        }
        .frame(width: UIScreen.main.bounds.width * 0.5)
        .padding(20)
    }
}
