//
//  AvatarView.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 21/11/25.
//

import SwiftUI

struct ProductItem: View {
    let product: Product
 
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                Circle()
                    .fill(product.getInStockBackground())
                    .frame(width: 8, height: 8)

                Text(
                    "\(product.inStock ?? 0) en existencia"
                )
                .font(.caption)
                .foregroundColor(.gray)

                Spacer()
            }
            .padding(.top, 16)
            .padding(.leading, 4)
            .padding(.bottom, 8)

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
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0
                        ).frame(height: 140)

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
                    ).background(
                        Color.secondary.opacity(0.1)
                    ).clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 20,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 20
                        )
                    )

                @unknown default:
                    EmptyView()
                }
            }
            VStack {
                Text(product.productName ?? "")
                    .font(.headline)
                    .foregroundColor(Color.PrimaryWhite)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .topLeading
                    ).padding(.leading, 5).padding(.top, 4)

                Spacer()

                Text(
                    "\(product.productPriceSale ?? 0, format: .currency(code: "MXN"))"
                )
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(Color.PrimaryWhite)
                .padding(.trailing, 5)
                .padding(.bottom, 4)
                .frame(
                    maxWidth: .infinity,
                    alignment: .trailing
                )
            }

            .background(Color.PrimaryBlack)

        }
        .background(Color.clear)
        .cornerRadius(12)

        .frame(
            maxWidth: .infinity,
            alignment: .topLeading
        )
    }
}
