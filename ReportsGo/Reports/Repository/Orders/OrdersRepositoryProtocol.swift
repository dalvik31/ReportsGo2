//
//  OrdersRepositoryProtocol.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 21/11/25.
//

protocol OrdersRepositoryProtocol {
    func getMainOrders() async throws -> [OrderMain]
}
