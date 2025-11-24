//
//  Extensionts.swift
//  DalvikNotes
//
//  Created by Emmanuel Pacheco on 13/11/25.
//

import SwiftUI

struct SecondaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        SecondaryButtonBody(configuration: configuration)
    }

    private struct SecondaryButtonBody: View {
        @Environment(\.isEnabled) private var isEnabled
        let configuration: Configuration

        var body: some View {
            configuration.label
                .padding()
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundStyle(foregroundColor)
                .cornerRadius(10)
                .scaleEffect(configuration.isPressed ? 0.90 : 1.0)
                .animation(.easeOut(duration: 0.3), value: configuration.isPressed)
        }


        private var foregroundColor: Color {
            isEnabled ? Color.PrimaryBlack : Color.PrimaryBlack.opacity(0.2)
        }
    }
}
