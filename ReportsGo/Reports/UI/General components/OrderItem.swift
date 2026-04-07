//
//  AvatarView.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 21/11/25.
//

import SwiftUI

struct OrderItem: View {
    let order: Order

    var body: some View {
        VStack {
            HStack {
                Text(order.orderName ?? "")
                    .font(.headline)
                    .foregroundStyle(
                        order.orderBuy ?? false == true
                            ? Color.PrimaryBlack.opacity(0.5)
                            : Color.PrimaryBlack
                    )
                    .strikethrough(order.orderBuy ?? false)

                Spacer()
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.PrimaryBlack)
                        .frame(height: 25)

                    Text(
                        order.id.formattedDate(format: Constants.Date.FORMAT_2)
                    )
                    .font(.caption)
                    .foregroundColor(Color.PrimaryWhite)
                    .padding(.horizontal, 8)
                }
                .fixedSize()
            }.padding(.bottom, 20)
            OrderText(text: "Descripcion: \(order.orderDescription ?? "")", orderBuy: order.orderBuy ?? false)
            OrderText(text: "Talla: \(order.orderSize ?? "")", orderBuy: order.orderBuy ?? false)
            OrderText(text: "Color: \(order.orderColor ?? "")", orderBuy: order.orderBuy ?? false)
            OrderText(text: "Genero: \(order.orderGender ?? "")", orderBuy: order.orderBuy ?? false)
            
            if(order.orderClientName?.isEmpty == false){
                OrderText(text: "Cliente: \(order.orderClientName ?? "")", orderBuy: order.orderBuy ?? false)
            }
        }

        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        ).background(Color.clear)
    }
}

struct OrderItemPreview: PreviewProvider {
    static var previews: some View {

        return OrderItem(order: Order())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
