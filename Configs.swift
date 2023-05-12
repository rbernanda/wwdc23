//
//  Configs.swift
//  wwdc-2023
//
//  Created by Roli Bernanda on 15/04/23.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: Int, alpha: Double = 1.0) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
    
    static let primaryColor = Color(hex: 0xCF0031)
    static let accentColor = Color(hex: 0xF9A307)
    static let lightBlack = Color(hex: 0xFFFFFF, alpha: 0.05)
    static let lightGreen = Color(hex: 0x22C39E)
    
    static let darkBlack = Color(hex: 0x060D2C)
    
    static let borderColor = Color(hex: 0xFFFFFF, alpha: 0.5)
    static let softGreen = Color(hex: 0x8dd9b9, alpha: 0.8)
}

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
