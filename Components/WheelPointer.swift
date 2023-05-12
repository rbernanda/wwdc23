//
//  SwiftUIView.swift
//
//
//  Created by Roli Bernanda on 12/04/23.
//

import SwiftUI

struct Triangle: Shape {
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.minY), control1: CGPoint(x: rect.maxX, y: rect.minY), control2: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct WheelPointer: View {
    var pointerColor: Color
    var body: some View {
        Triangle().frame(width: 50, height: 50)
            .foregroundColor(pointerColor).cornerRadius(24)
            .rotationEffect(.init(degrees: 180))
            .shadow(color: Color.orange, radius: 5, x: 0.0, y: 1.0)
    }
}
