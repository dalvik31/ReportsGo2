//
//  OrderMain.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 19/11/25.
//

import FirebaseDatabase

struct Order: Identifiable, Codable {
    var orderId: String? = ""
    var id: String {
        self.orderId ?? ""
    }
    var orderBuy: Bool? = false
    var orderColor: String? = ""
    var orderColorCode: String? = ""
    var orderDescription: String? = ""
    var orderGender: String? = ""
    var orderListId: String? = ""
    var orderName: String? = ""
    var orderSeason: OrderSeason? = OrderSeason.UNKNOWN
    var orderSizeNumeric: Bool? = false
    var orderSize: String? = ""
    var orderClientName: String? = ""
    var orderClientId: String? = ""

    init() {
        self.orderId = ""
        self.orderName = "Primer pedido"
        self.orderBuy = false
        self.orderColor = ""
        self.orderColorCode = ""
        self.orderDescription = ""
        self.orderGender = ""
        self.orderListId = ""
        self.orderSeason = OrderSeason.UNKNOWN
        self.orderSizeNumeric = false
        self.orderSize = ""
        self.orderClientId = ""
        self.orderClientName = ""
    }

    init?(value: [String: Any]?) {
        guard
            let orderId = value?["orderId"] as? String,
            let orderName = value?["orderName"] as? String,
            let orderBuy = value?["orderBuy"] as? Bool,
            let orderColor = value?["orderColor"] as? String,
            let orderColorCode = value?["orderColorCode"] as? String,
            let orderDescription = value?["orderDescription"] as? String,
            let orderGender = value?["orderGender"] as? String,
            let orderListId = value?["orderListId"] as? String,
            let orderSeason = value?["orderSeason"] as? String,
            let orderSizeNumeric = value?["orderSizeNumeric"] as? Bool,
            let orderSize = value?["orderSize"] as? String
      
        else {
            return nil
        }
        
        let orderClientId = value?["orderClientId"] as? String
        let orderClientName = value?["orderClientName"] as? String
        
        
        self.orderId = orderId
        self.orderName = orderName
        self.orderBuy = orderBuy
        self.orderColor = orderColor
        self.orderColorCode = orderColorCode
        self.orderDescription = orderDescription
        self.orderGender = orderGender
        self.orderListId = orderListId
        self.orderSeason = OrderSeason(rawValue: orderSeason)
        self.orderSizeNumeric = orderSizeNumeric
        self.orderSize = orderSize
        self.orderClientId = orderClientId
        self.orderClientName = orderClientName
    }

}
