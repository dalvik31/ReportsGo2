//
//  Extensionts.swift
//  DalvikNotes
//
//  Created by Emmanuel Pacheco on 13/11/25.
//

import SwiftUI

extension Color {
    public static let PrimaryBlack = Color("PrimaryBlack")
    public static let PrimaryWhite = Color("PrimaryWhite")
    public static let Orange = Color("Orange")
}

extension TextField {
    public func withLoginStyles() -> some View {
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

extension SecureField {
    public func withSecureFieldStyles() -> some View {
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

extension View {
    #if canImport(UIKit)
        public func hideKeyboard() {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
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

    func formattedDate(format: String = Constants.Date.FORMAT_1) -> String {
        let timestamp = Int64(self.isEmpty ? "0" : self) ?? 0
        let timeInterval = TimeInterval(timestamp) / 1000.0
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: date)
    }
}


extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(
        _ gestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return viewControllers.count > 1
    }
}
