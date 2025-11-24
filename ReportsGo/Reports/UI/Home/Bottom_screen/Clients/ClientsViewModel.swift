//
//  OrdersViewModel.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 19/11/25.
//

import SwiftUI
import Combine

@MainActor
class ClientsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var clients: [Client] = []
    
    
    private let clientsRepository: ClientsRepositoryProtocol
    
    init(clientsRepository: ClientsRepositoryProtocol? = nil) {
        let repository = clientsRepository ?? ClientsRepository()
        self.clientsRepository = repository
    }
    
    
    func getClients() async {
        isLoading = true
        
        defer { isLoading = false }
    
        self.clients = await clientsRepository.getClients()
    }
    
}
