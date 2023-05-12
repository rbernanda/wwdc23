//
//  SwiftUIView.swift
//  
//
//  Created by Roli Bernanda on 12/05/23.
//

import SwiftUI

struct BankruptModal: View {
    @Environment(\.presentationMode) var presentationMode
    var action: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            
            Text("Your balance is currently at zero")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Text("To refresh your balance, simply hit the restart button.")
                .multilineTextAlignment(.center)
                .foregroundColor(Color.borderColor)
            
            Spacer()
            HStack(spacing: 20) {
                Button(action: {
                    self.action()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Restart")
                        .padding()
                        .foregroundColor(.darkBlack)
                        .frame(maxWidth: .infinity)
                })
                .background(Color.lightGreen)
                .cornerRadius(8)
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Close")
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                })
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.borderColor, lineWidth: 0.5)
                )
                .cornerRadius(8)
            }
        }
        .padding()
        .cornerRadius(8)
        .shadow(radius: 10)
        .background(Color.darkBlack)
    }
}
