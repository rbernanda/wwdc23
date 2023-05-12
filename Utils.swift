//
//  Utils.swift
//  wwdc-2023
//
//  Created by Roli Bernanda on 15/04/23.
//

import Foundation
import SwiftUI

func typeWriter(finalText: String, text: Binding<String>, at position: Int = 0) {
    if position == 0 {
        text.wrappedValue = ""
    }
    if position < finalText.count {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            text.wrappedValue.append(finalText[position])
            typeWriter(finalText: finalText, text: text, at: position + 1)
        }
    }
}
