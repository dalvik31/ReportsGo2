//
//  OrdersRepositoryProtocol.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 21/11/25.
//

protocol ProductsRepositoryProtocol {
    func getProducts() async  -> [Product]
}
