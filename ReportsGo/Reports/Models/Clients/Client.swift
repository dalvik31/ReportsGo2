//
//  OrderMain.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 19/11/25.
//

import FirebaseDatabase
import SwiftUI

struct Client: Identifiable, Codable {
    var id: String? = ""
    var clientFullName: String {
        "\(self.name ?? "") \(self.lastNanme ?? "")"
    }
    var clientPhoneNumber: String {
        self.phone ?? ""
    }
    var dateClient: String? = ""
    var debt: Float? = 0
    var detail: String? = ""
    var lastNanme: String? = ""
    var limit: Float? = 0.0
    var name: String? = ""
    var phone: String? = ""

    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
            let id = value["id"] as? String,
            let dateClient = value["dateClient"] as? String,
            let debt = value["debt"] as? Float,
            let detail = value["detail"] as? String,
            let lastNanme = value["lastNanme"] as? String,
            let limit = value["limit"] as? Float,
            let name = value["name"] as? String,
            let phone = value["phone"] as? String
        else {
            return nil
        }

        self.id = id
        self.dateClient = dateClient
        self.debt = debt
        self.detail = detail
        self.lastNanme = lastNanme
        self.limit = limit
        self.name = name
        self.phone = phone

    }
    
    func getClientDotBackground() -> Color {
        // Swift's switch statement handles ranges concisely, similar to Kotlin's 'when'
        switch self.geProgressLimit() {
        case 0.0001...0.4:
            return Color.green
        case 0.4...0.8:
            return Color.yellow
        case 0.8...1.0:
            return Color.red
        default:
            return Color.green
        }
    }
    
    
    func geProgressLimit() -> Float {
        var limitCredit: Float = 0.0
        if ((self.debt ?? 0) > 0) {
            limitCredit = (self.debt ?? 0) / (self.limit ?? 0)
          }
          return limitCredit
      }

}
