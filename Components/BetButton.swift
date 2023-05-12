//
//  SwiftUIView.swift
//  
//
//  Created by Roli Bernanda on 12/05/23.
//

import SwiftUI

struct BetButton: View {
    let betAmount: String
    let betAction: () -> Void
    let backgroundColor: Color
    let betPayout: String
    
    var body: some View {
        VStack {
            Text("$\(betAmount)").font(.system(size: 24, weight: .thin))
            
            Button(action: betAction, label: {
                ZStack {
                    Rectangle()
                        .fill(backgroundColor)
                        .frame(width: 76, height: 76)
                    Text("\(betPayout)")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                }
            })
            .cornerRadius(8)
            .padding(.horizontal)
        }
    }
}
