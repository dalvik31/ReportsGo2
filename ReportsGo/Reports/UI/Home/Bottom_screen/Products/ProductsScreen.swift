//
//  OrdersScreen.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 18/11/25.
//

import SwiftUI

struct ProductsScreen: View {
    @EnvironmentObject var productsViewModel: ProductsViewModel
    @State private var showingAddProduct = false
    @State private var showingProfile: Bool = false
    private var price = 2.099
    var body: some View {

        VStack(spacing: 8) {

            NavigationView {
                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 10),
                            GridItem(.flexible(), spacing: 10),
                        ],
                        spacing: 0
                    ) {
                        ForEach(productsViewModel.products) { product in
                            ProductItem(product: product)
                        }
                    }.padding(.horizontal, 10)
                }
                .navigationTitle("Products")
                .navigationBarItems(
                    trailing: HStack(spacing: 24) {
                        Button {
                            showingProfile = true
                        } label: {
                            Image(systemName: "person.crop.circle")
                        }

                        Button {
                            showingAddProduct = true
                        } label: {
                            Image(systemName: "plus")
                        }

                    }

                )
                .onAppear {
                    getProducts()
                }
                .sheet(isPresented: $showingAddProduct) {
                    //AddNoteView(firestoreManager: firestoreManager)
                }
                .sheet(isPresented: $showingProfile) {
                    ProfileScreen()
                }.overlay {

                    if productsViewModel.isLoading {
                        LoadingView()
                    }
                }

            }

        }

    }

    private func getProducts() {
        Task {
            await productsViewModel.getProducts()
        }

    }
}
