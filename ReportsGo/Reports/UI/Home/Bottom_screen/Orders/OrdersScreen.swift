//
//  OrdersScreen.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 18/11/25.
//

import SwiftUI

struct OrdersScreen: View {
    @EnvironmentObject var ordersMainViewModel: OrdersMainViewModel

    @State private var showingAddOrder = false
    @State private var showingProfile: Bool = false
    @State private var downloadAmount = 0.0

    var body: some View {

        VStack(spacing: 8) {

            NavigationView {
                List {
                    ForEach(ordersMainViewModel.orders) { order in
                        // Main container (the card itself)
                        VStack {
                            HStack {
                                // Green status indicator
                                Circle()
                                    .fill(
                                        Color(red: 0.3, green: 0.7, blue: 0.3)
                                    )  // A sample green color
                                    .frame(width: 10, height: 10)

                                // Main date text
                                Text(order.nameOrder ?? "")
                                    .font(.headline)
                          

                                Spacer()

                                // Top right dark label (ZStack used for background shape)
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.PrimaryBlack)
                                        .frame(height: 25)

                                    Text(order.orderDate ?? "")
                                        .font(.caption)
                                        .foregroundColor(Color.PrimaryWhite)
                                        .padding(.horizontal, 8)
                                }
                                .fixedSize()  // Prevents the ZStack from expanding unnecessarily
                            }.padding(.bottom, 20)

                            // A representation of the progress line using a custom view or Rectangle
                            HStack {
                                //ProgressView("Downloading...", value: order.getOrderProgress(), total: order.orderLists.count) // Progress bar with label, current value, and total

                                ProgressView(
                                    value: order.getOrderProgress(),
                                    total: 100
                                )
                                // The faint purple line (simulated as a thin rectangle)

                                // "0 Pedidos" text
                                Text(order.orderLists.count == 0 ? "0 Pedidos" : "\(order.orderLists.count) Pedidos")
                                    .font(.subheadline)
                           
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
                .swipeActions {
                    Button("Edit") {
                        // handle editing note here
                        //showingAddNote = true
                    }
                    .tint(.blue)
                }

                .navigationTitle("Orders")
                .navigationBarItems(
                    trailing:
                        HStack(spacing: 24) {
                            Button {
                                showingProfile = true
                            } label: {
                                Image(systemName: "person.crop.circle")
                            }

                            Button {
                                showingAddOrder = true
                            } label: {
                                Image(systemName: "plus")
                            }

                        }
                )

                .onAppear {
                    getOrdersMain()

                }
                .sheet(isPresented: $showingAddOrder) {
                    //AddNoteView(firestoreManager: firestoreManager)
                }
                .sheet(isPresented: $showingProfile) {
                    ProfileScreen()
                }
                .overlay {

                    if ordersMainViewModel.isLoading {
                        LoadingView()
                    }
                }
            }

        }

    }

    private func getOrdersMain() {
        Task {
            await ordersMainViewModel.getOrdersMain()
        }
    }
}
