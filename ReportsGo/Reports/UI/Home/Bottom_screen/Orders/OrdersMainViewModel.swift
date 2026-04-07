//
//  OrdersViewModel.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 19/11/25.
//

import Combine
import SwiftUI

@MainActor
class OrdersMainViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var ordersMain: [OrderMain] = []
    @Published var error: OrdersError?

    private let ordersRepository: OrdersRepositoryProtocol

    init(ordersRepository: OrdersRepositoryProtocol? = nil) {
        let repository = ordersRepository ?? OrdersRepository()
        self.ordersRepository = repository
    }

    func getOrdersMain() async {
        isLoading = true

        defer { isLoading = false }

        do {
            self.ordersMain = try await ordersRepository.getMainOrders()

        } catch let ordersError as OrdersError {
            self.error = ordersError
        } catch {
            self.ordersMain = []
            self.error = .orderMainEmpty
            print(error.localizedDescription)
        }
    }

    func sendOrder(order: Order) async {
        print("Orden a guardar : \(order)")
        /* isLoading = true
        
         defer { isLoading = false }
        
         do {
             //self.ordersMain = try await ordersRepository.getMainOrders()
        
         }catch let ordersError as OrdersError {
             self.error = ordersError
         } catch {
             self.ordersMain = []
             self.error = .orderMainEmpty
             print(error.localizedDescription)
         }*/
    }

}
