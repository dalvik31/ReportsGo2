//
//  OrderStatus.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 20/11/25.
//

import Foundation

enum OrderSeason: String, Codable {
    case FALL
    case SPRING
    
    var description: String {
          switch self {
          case .FALL:
              String(localized: "Otoño - Invierno")
          case .SPRING:
              String(localized: "Primavera - Verano")
          }
      }
}

