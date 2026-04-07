//
//  OrdersScreen.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 18/11/25.
//

import SwiftUI

struct OrdersMainSreen: View {
    @EnvironmentObject var ordersMainViewModel: OrdersMainViewModel

    @State private var showingAddOrder = false
    @State private var showingProfile: Bool = false
    @State private var downloadAmount = 0.0

    var body: some View {
        NavigationView {

            VStack {

                List {
                    ForEach(ordersMainViewModel.ordersMain) { order in
                        // Main container (the card itself)

                        NavigationLink(
                            destination: OrdersDetailListScreen(
                                orders: order.orderLists
                            ).navigationBarBackButtonHidden(true)
                           
                        ) {
                            OrderMainItem(orderMain: order).swipeActions {
                                Button("Edit") {
                                    // handle editing note here
                                    //showingAddNote = true
                                }
                                .tint(.blue)
                            }
                        }
                    }
                }
                if let error = ordersMainViewModel.error {
                    Text(error.localizedDescription)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.bottom, 12)
                        .transition(.opacity)
                }
            }

            .scrollContentBackground(.hidden).background(Color.clear)
            .navigationViewStyle(.stack)
    
            .navigationTitle("Orders")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingProfile = true
                    } label: {
                        Image(systemName: "person.crop.circle")
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddOrder = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
       

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

    private func getOrdersMain() {
        Task {
            await ordersMainViewModel.getOrdersMain()
        }
    }
}
