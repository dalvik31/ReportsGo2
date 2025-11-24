//
//  Extensionts.swift
//  DalvikNotes
//
//  Created by Emmanuel Pacheco on 13/11/25.
//

import SwiftUI

public extension Color {
    static let PrimaryBlack = Color("PrimaryBlack")
    static let PrimaryWhite = Color("PrimaryWhite")
    static let Orange = Color("Orange")
}

public extension TextField {
    func withLoginStyles() -> some View {
        self.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.PrimaryBlack, lineWidth: 2)
            )
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(.bottom, 20)
    }
}

public extension SecureField {
    func withSecureFieldStyles() -> some View {
        self.padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.PrimaryBlack, lineWidth: 2)
            )
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(.bottom, 20)
    }
}

public extension View {
    #if canImport(UIKit)
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    #endif
}


extension String {
    var initials: String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
        let firstLetters = components.compactMap { $0.first?.uppercased() }
        return firstLetters.joined()
    }
}
