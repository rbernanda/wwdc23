//
//  SwiftUIView.swift
//  
//
//  Created by Roli Bernanda on 12/05/23.
//

import SwiftUI

struct HowToPlayModal: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ScrollView {
                Spacer()
                Text("How To Play")
                    .font(.system(.title))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("**1**. You can find your balance and value bet in the top left corner.")
                        Image("betting-area-view")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        
                        Text("**2**. You can enter the amount you wish to wager in the \"Bet Amount\" section.")
                        Image("bet-amount-view")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        
                        Text("**3**. Once you have entered a value, you can choose one or more colors to play by tapping on any of these 3 buttons. Playing with different values for each selected color is also an option. Once you have placed your bet, tap on the spin button to spin the wheel. \n\nPlease note that if your placed bet amount exceeds your balance, you will not be able to spin the wheel.")
                        Image("bet-buttons-view")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        
                        
                        Text("**4**. You have the option to clear the value of a previously placed bet or to restart the game.")
                        Image("clear-restart-view")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        
                        Text("**5**. Your betting history can be viewed here.")
                        Image("bet-history")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity)
            .font(.system(.body))
            .foregroundColor(.white)
            .padding()
            
            
            Spacer()
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Close")
                    .padding()
                    .foregroundColor(.darkBlack)
                    .frame(maxWidth: .infinity)
            })
            .background(Color.lightGreen)
            .cornerRadius(8)
        }
        .padding()
        .cornerRadius(8)
        .shadow(radius: 10)
        .background(Color.darkBlack)
    }
}
