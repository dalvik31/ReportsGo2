//
//  OrdersError.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 15/11/25.
//
import SwiftUI
import Foundation

enum OrdersError: Error, LocalizedError {
    case orderMainEmpty

    var errorDescription: String? {
        switch self {
        case .orderMainEmpty:
            return String(localized: "OrdersMainEmpty")
        }
    }
}
