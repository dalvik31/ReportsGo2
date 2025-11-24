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

class OrdersRepository: NSObject, OrdersRepositoryProtocol {

    private let databaseRef: DatabaseReference

    override init() {
        self.databaseRef = Database.database().reference()
    }

    internal func getMainOrders() async -> [OrderMain] {
        var ordersMain: [OrderMain] = []
        let questionPostsRef = self.databaseRef.child(
            Constants.FIRE_BASE_REALTIME_DATABASE_NAME
        )
        let query = questionPostsRef.child(Auth.auth().currentUser?.uid ?? "")
            .child(
                Constants.ORDERS_TABLE_NAME
            )

        do {
            let snapshot = try await query.getData()

            let children = snapshot.children.allObjects as? [DataSnapshot] ?? []
            for child in children {
                if let order = OrderMain(snapshot: child) {
                    ordersMain.append(order)
                }
            }
            return ordersMain

        } catch {
            return ordersMain
        }
    }

}
