//
//  OrderStatus.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 20/11/25.
//

import Foundation

enum OrderStatus: String, Codable {
    case IN_PROGRESS
    case DONE
    
    var description: String {
          switch self {
          case .IN_PROGRESS:
              String(localized: "InProgress")
          case .DONE:
              String(localized: "Done")
          }
      }
}

