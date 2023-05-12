//
//  SwiftUIView.swift
//
//
//  Created by Roli Bernanda on 12/04/23.
//

import SwiftUI

struct WheelBolt: View {
    var body: some View {
        ZStack {
            Circle().frame(width: 28, height: 28)
                .foregroundColor(Color.orange)
            Circle().frame(width: 18, height: 18)
                .foregroundColor(Color.orange)
                .shadow(color: Color.orange, radius: 3, x: 0.0, y: 1.0)
        }
    }
}
