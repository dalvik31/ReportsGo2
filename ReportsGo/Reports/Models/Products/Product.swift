//
//  OrderMain.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 19/11/25.
//

import FirebaseDatabase
import SwiftUI

struct Product: Identifiable, Codable {
    var id: String {
        self.productId ?? ""
    }
    var productDate: String? = ""
    var productId: String? = ""
    var urlImage: String? = ""
    var productName: String? = ""
    var productDescription: String? = ""
    var productType: String? = ""
    var productPriceBuy: Double? = 0.0
    var productPriceSale: Double? = 0.0
    var productCode: String? = ""
    var productSize: String? = ""
    var productSizeNumeric: Bool? = false
    var productColor: String? = ""
    var productColorCode: String? = ""
    var inStock: Int? = 0
    var auxPrice: Double? = 0.0
    var auxStock: Int? = 0
    var talla: String? = ""
    var color: String? = ""
    var tipo_de_empaque: String? = ""
    var especificaciones_otro: String? = ""
    var typeProduct: String? = ""

    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any]
        else {
            return nil
        }

        // Optional fields handled outside the guard
        let productId = value["productId"] as? String
        let productDate = value["productDate"] as? String
        let urlImage = value["urlImage"] as? String
        let productName = value["productName"] as? String
        let productDescription = value["productDescription"] as? String
        let productType = value["productType"] as? String
        let productPriceBuy = value["productPriceBuy"] as? Double
        let productPriceSale = value["productPriceSale"] as? Double
        let productCode = value["productCode"] as? String
        let talla = value["talla"] as? String
        let color = value["color"] as? String
        let inStock = value["inStock"] as? Int
        let productSize = value["productSize"] as? String
        let productColor = value["productColor"] as? String
        let productColorCode = value["productColorCode"] as? String
        let tipo_de_empaque = value["tipo_de_empaque"] as? String
        let especificaciones_otro = value["especificaciones_otro"] as? String
        let typeProduct = value["typeProduct"] as? String

        self.productId = productId
        self.productDate = productDate
        self.urlImage = urlImage
        self.productName = productName
        self.productDescription = productDescription
        self.productType = productType
        self.productPriceBuy = productPriceBuy
        self.productPriceSale = productPriceSale
        self.productCode = productCode
        self.talla = talla
        self.color = color
        self.inStock = inStock
        self.productSize = productSize
        self.productColor = productColor
        self.productColorCode = productColorCode
        self.tipo_de_empaque = tipo_de_empaque
        self.especificaciones_otro = especificaciones_otro
        self.typeProduct = typeProduct
    }

    func getInStockBackground() -> Color {
        switch self.inStock ?? 0 {
        case 0:
            return Color.gray
        case 1...5:
            return Color.red
        case 5...10:
            return Color.yellow
        case 10...Int.max:
            return Color.green
        default:
            return Color.gray
        }
    }

}
