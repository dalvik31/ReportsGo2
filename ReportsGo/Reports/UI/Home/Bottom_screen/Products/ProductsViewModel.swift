//
//  OrdersViewModel.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 19/11/25.
//

import SwiftUI
import Combine

@MainActor
class ProductsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var products: [Product] = []
    
    
    private let productsRepository: ProductsRepositoryProtocol
    
    init(productsRepository: ProductsRepositoryProtocol? = nil) {
        let repository = productsRepository ?? ProductsRepository()
        self.productsRepository = repository
    }
    
    
    func getProducts() async {
        isLoading = true
        
        defer { isLoading = false }
        
        do {
            self.products  = try await productsRepository.getProducts()
            
        } catch {
            print(error.localizedDescription)
        }

    }
    
}
