//
//  OrderMain.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 19/11/25.
//

import FirebaseDatabase

struct OrderMain: Identifiable, Codable {
    var orderId: String? = ""
    var id: String {
        self.orderId ?? ""
    }
    var nameOrder: String? = ""
    var dateOrder: String? = ""
    var orderDate: String? = ""
    var orderStatus: OrderStatus? = OrderStatus.IN_PROGRESS
    var orderSeason: OrderSeason? = OrderSeason.FALL
    var orderLists: [Order] = []

    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
              let orderId = value["orderId"] as? String,
              let nameOrder = value["nameOrder"] as? String,
              let dateOrder = value["dateOrder"] as? String,
              let orderDate = value["orderDate"] as? String,
              let orderStatus = value["orderStatus"] as? String,
              let orderSeason = value["orderSeason"] as? String
        else {
            return nil
        }

        self.orderId = orderId
        self.nameOrder = nameOrder
        self.dateOrder = dateOrder
        self.orderDate = orderDate
        self.orderStatus = OrderStatus(rawValue: orderStatus)
        self.orderSeason = OrderSeason(rawValue: orderSeason)

        // Parse orderLists if present
        if let orderListsDict = value["orderLists"] as? [String: Any] {
            var parsedOrders: [Order] = []
            for (_, v) in orderListsDict {
                if let dict = v as? [String: Any], let order = Order(value: dict) {
                    parsedOrders.append(order)
                }
            }
            self.orderLists = parsedOrders
        } else {
            self.orderLists = []
        }
    }
    
    func getOrderProgress() -> Float {
        let completed = self.orderLists.filter { $0.orderBuy ?? false }.count
        let total = self.orderLists.count
          let progress = total > 0 ? Double(completed) / Double(total) : 0
        return  Float(progress * 100.0) as Float
    }

}
