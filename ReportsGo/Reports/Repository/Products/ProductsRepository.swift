//
//  AuthRepository.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 15/11/25.
//

import FirebaseAuth
import FirebaseDatabase
import Foundation
import UIKit

class ProductsRepository: NSObject, ProductsRepositoryProtocol {

    private let databaseRef: DatabaseReference

    override init() {
        self.databaseRef = Database.database().reference()
    }

    internal func getProducts() async -> [Product] {
        var products: [Product] = []
        let questionPostsRef = self.databaseRef.child(
            Constants.FIRE_BASE_REALTIME_DATABASE_NAME
        )
        let query = questionPostsRef.child(Auth.auth().currentUser?.uid ?? "")
            .child(
                Constants.PRODUCTS_TABLE_NAME
            )

        do {
            let snapshot = try await query.getData()

            let children = snapshot.children.allObjects as? [DataSnapshot] ?? []
            for child in children {
                if let product = Product(snapshot: child) {
                    products.append(product)
                }
            }
            return products

        } catch {
            return products
        }
    }

}
