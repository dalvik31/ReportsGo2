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
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                        ],
                        spacing: 1
                    ) {
                        ForEach(productsViewModel.products) { product in
                            // Main container (the card itself)
                            // Main container (the card itself)
                            VStack(alignment: .leading, spacing: 0) {
                                // Top status indicator area
                                HStack(spacing: 8) {
                                    Circle()
                                        .fill(product.getInStockBackground())
                                        .frame(width: 8, height: 8)

                                    Text(
                                        "\(product.inStock ?? 0) en existencia"
                                    )
                                    .font(.caption)
                                    .foregroundColor(.gray)

                                    Spacer()  // Pushes everything to the left
                                }
                                .padding(.top, 16)
                                .padding(.leading, 4)
                                .padding(.bottom, 8)

                                // Green image background area (Placeholder for Pokemon images)

                                AsyncImage(
                                    url: URL(string: product.urlImage ?? "")
                                ) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView().frame(
                                            maxWidth: .infinity
                                        )
                                        .frame(height: 140)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 140)
                                            .clipShape(
                                                UnevenRoundedRectangle(
                                                    cornerRadii: .init(
                                                        topLeading: 20,
                                                        topTrailing: 20
                                                    )
                                                )
                                            )
                                    case .failure:
                                        VStack {
                                            Image(
                                                systemName:
                                                    "cart"
                                            )
                                            .resizable()
                                            .scaledToFit()

                                            .frame(height: 40)
                                            .foregroundColor(.secondary)

                                        }
                                        .frame(
                                            maxWidth: .infinity
                                        ).frame(
                                            height: 140
                                        ).background(Color.secondary.opacity(0.1)).clipShape(
                                            UnevenRoundedRectangle(
                                                topLeadingRadius: 20,  // Apply radius to top-left corner
                                                bottomLeadingRadius: 0,  // No radius for bottom-left
                                                bottomTrailingRadius: 0,  // No radius for bottom-right
                                                topTrailingRadius: 20  // Apply radius to top-right corner
                                            )
                                        )

                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                //Image("yourImageName") // Replace "yourImageName" with the actual name of your image asset

                                //.clipShape(Rectangle().cornerRadius(20, [.topLeft, .topRight]))

                                // White background area for Kanto and Price
                                VStack {
                                    Text(product.productName ?? "")
                                        .font(.headline)
                                        .foregroundColor(Color.PrimaryWhite)
                                        .frame(
                                            maxWidth: .infinity,
                                            alignment: .topLeading
                                        ).padding(.leading, 4).padding(.top, 4)

                                    Spacer()  // Pushes Kanto left and Price right

                                    Text("\(product.productPriceSale ?? 0, format: .currency(code: "MXN"))")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.PrimaryWhite)
                                        .padding(.trailing, 4)
                                        .padding(.bottom, 4)
                                        .frame(
                                            maxWidth: .infinity,
                                            alignment: .trailing
                                        )
                                }

                                .background(Color.PrimaryBlack)  // Ensure the bottom part is white

                            }
                            .background(Color.clear)  // Main card background color
                            .cornerRadius(12)
                            .shadow(
                                color: Color.black.opacity(0.1),
                                radius: 8,
                                x: 0,
                                y: 4
                            )
                            .padding()  // Padding around the entire card for a background effect
                            .frame(
                                maxWidth: .infinity,
                                alignment: .topLeading
                            )

                        }
                    }
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
