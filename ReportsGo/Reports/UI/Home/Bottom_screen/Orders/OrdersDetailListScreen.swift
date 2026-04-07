//
//  OrdersScreen.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 18/11/25.
//

import SwiftUI

struct OrdersDetailListScreen: View {

    let orders: [Order]
    @Environment(\.dismiss) var dismiss

    var body: some View {

        NavigationView {

            List {
                ForEach(orders) { orderDetail in
                    NavigationLink(
                        destination: OrderScreen(order: orderDetail)
                            .navigationBarBackButtonHidden(true)

                    ) {

                        OrderItem(order: orderDetail).swipeActions {
                            Button("Edit") {
                                // handle editing note here
                                //showingAddNote = true
                            }
                            .tint(.blue)
                        }
                    }

                }
            }.scrollContentBackground(.hidden).background(Color.clear)

                /*HStack {
                 VStack(alignment: .leading) {
                 Text(order.nameOrder ?? "").font(.headline)
                 Text(order.dateOrder ?? "").font(.subheadline)
                 Text(order.orderDate ?? "").font(.subheadline)
                 Text(order.orderStatus?.description ?? OrderStatus.IN_PROGRESS.description).font(.subheadline)
                 Text(order.orderSeason?.description ?? OrderSeason.FALL.description).font(.subheadline)
                 Text("Pedidos: \(order.orderLists.count)").font(.subheadline)
                 Text(String(format: "Progress: %.0f%%", order.getOrderProgress()))
                 //Text("Progress: \(order.getProgress())").font(.subheadline)
                 }
                 Spacer()
                 Button("Delete") {
                
                 }
                 }*/

            .navigationTitle("\(orders.count) Orders")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        // A custom back button view
                        Button(
                            action: {
                                dismiss()  // Dismisses the current view and goes back
                            }) {
                                HStack(spacing: 4) {  // Use an HStack to mimic the system look
                                    Image(systemName: "chevron.left")

                                }
                            }
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {

                        Button {

                        } label: {
                            NavigationLink(
                                destination: OrderScreen(order: nil)
                                    .navigationBarBackButtonHidden(true)

                            ) {

                                Image(systemName: "plus")
                            }
                        }

                    }
                }

                .navigationBarTitleDisplayMode(.inline)

        } .navigationViewStyle(.stack)
        

    }

    /* private func getOrdersMain() {
     Task {
     await ordersMainViewModel.getOrderDetail(id: 22)
     }
     }*/

}
