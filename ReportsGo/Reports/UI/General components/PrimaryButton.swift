//
//  Extensionts.swift
//  DalvikNotes
//
//  Created by Emmanuel Pacheco on 13/11/25.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        PrimaryButtonBody(configuration: configuration)
    }

    private struct PrimaryButtonBody: View {
        @Environment(\.isEnabled) private var isEnabled
        let configuration: Configuration

        var body: some View {
            configuration.label
                .padding()
                .font(.headline)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .foregroundStyle(foregroundColor)
                .cornerRadius(10)
                .scaleEffect(configuration.isPressed ? 0.90 : 1.0)
                .animation(.easeOut(duration: 0.3), value: configuration.isPressed)
        }

        private var backgroundColor: Color {
            if isEnabled {
                return configuration.isPressed ? Color.PrimaryBlack.opacity(0.8) : Color.PrimaryBlack
            } else {
                return Color.gray
            }
        }

        private var foregroundColor: Color {
            isEnabled ? Color.PrimaryWhite : Color.PrimaryWhite.opacity(0.7)
        }
    }
}
