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
    case UNKNOWN
    
    var description: String {
          switch self {
          case .FALL:
              String(localized: "fall")
          case .SPRING:
              String(localized: "spring")
          case .UNKNOWN:
              String(localized: "seasonUnknown")
          }

    }
      
}

