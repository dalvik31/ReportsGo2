//
//  ClientsRepositoryProtocol.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 21/11/25.
//

protocol ClientsRepositoryProtocol {
    func getClients() async -> [Client]
}
