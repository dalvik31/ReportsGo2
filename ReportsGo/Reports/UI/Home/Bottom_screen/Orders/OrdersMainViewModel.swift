//
//  OrdersViewModel.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 19/11/25.
//

import SwiftUI
import Combine

@MainActor
class OrdersMainViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var orders: [OrderMain] = []
    
    private let ordersRepository: OrdersRepositoryProtocol
    
    init(ordersRepository: OrdersRepositoryProtocol? = nil) {
        let repository = ordersRepository ?? OrdersRepository()
        self.ordersRepository = repository
    }
    
    
    func getOrdersMain() async {
        isLoading = true
        
        defer { isLoading = false }
        
        do {
            self.orders  = try await ordersRepository.getMainOrders()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
