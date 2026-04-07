//
//  OrdersScreen.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 18/11/25.
//

import SwiftUI

struct OrderScreen: View {

    let order: Order?

    @State private var orderName: String = ""
    @FocusState private var orderNameIsFocused: Bool

    @State private var orderDescription: String = ""
    @FocusState private var orderDescriptionIsFocused: Bool

    @EnvironmentObject var ordersMainViewModel: OrdersMainViewModel
    @Environment(\.dismiss) var dismiss

    init(order: Order?) {
        self.order = order
        _orderName = State(initialValue: order?.orderName ?? "")
        _orderDescription = State(initialValue: order?.orderDescription ?? "")
    }

    var body: some View {

        NavigationView {

            VStack(spacing: 0) {

                TextField("nameOrder", text: $orderName)
                    .withLoginStyles()
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .submitLabel(.next)
                    .focused($orderNameIsFocused)
                    .onSubmit {
                        orderNameIsFocused = false
                        orderDescriptionIsFocused = true
                    }

                TextField("nameDescription", text: $orderDescription)
                    .withLoginStyles()
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .submitLabel(.next)
                    .focused($orderDescriptionIsFocused)
                    .onSubmit {
                        sendOrder()
                    }

            }

            .navigationTitle(
                order != nil
                    ? "Edit \(orderName)" : "createOrderTitle"
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // A custom back button view
                    Button(action: {
                        dismiss()  // Dismisses the current view and goes back
                    }) {
                        HStack(spacing: 4) {  // Use an HStack to mimic the system look
                            Image(systemName: "chevron.left")

                        }
                    }
                }

            }

            .navigationBarTitleDisplayMode(.inline)

        } .navigationViewStyle(.stack)

    }

    private func sendOrder() {
        var orderToSend = Order()
        orderToSend.orderId = ""
        orderToSend.orderName = orderName
        orderToSend.orderDescription = orderDescription

        Task {
            await ordersMainViewModel.sendOrder(order: orderToSend)
        }
    }

}
