//
//  Extensionts.swift
//  DalvikNotes
//
//  Created by Emmanuel Pacheco on 13/11/25.
//

import SwiftUI


struct PrimaryIconButton: ButtonStyle {
    let title: String?
    let iconName: String?

    init(title: String? = nil, iconName: String? = nil) {
        self.title = title
        self.iconName = iconName
    }

    func makeBody(configuration: Configuration) -> some View {
        PrimaryIconButtonBody(
            configuration: configuration,
            title: title,
            iconName: iconName
        )
    }

    private struct PrimaryIconButtonBody: View {
        @Environment(\.isEnabled) private var isEnabled
        let configuration: Configuration
        let title: String?
        let iconName: String?

        var body: some View {
            content
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .foregroundStyle(foregroundColor)
                .cornerRadius(10)
                .scaleEffect(configuration.isPressed ? 0.90 : 1.0)
                .animation(
                    .easeOut(duration: 0.3),
                    value: configuration.isPressed
                )
        }

        @ViewBuilder
        private var content: some View {
            if let title, let iconName {
                Label {
                    Text(LocalizedStringKey(title))
                        .font(.headline)
                } icon: {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.blue)
                }
            } else if let title {
                Text(LocalizedStringKey(title))
            } else if let iconName {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(.blue)
            } else {
                configuration.label
            }
        }

        private var backgroundColor: Color {
            guard isEnabled else { return Color.gray }
            return configuration.isPressed ? Color.PrimaryBlack.opacity(0.8) :  Color.PrimaryBlack
        }

        private var foregroundColor: Color {
            isEnabled ? Color.PrimaryWhite : Color.PrimaryWhite.opacity(0.7)
        }
        
    }
}
