//
//  AvatarView.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 21/11/25.
//

import SwiftUI

struct OrderText: View {
    let text: String
    let orderBuy: Bool

    var body: some View {

        Text(text)
            .font(.subheadline)
            .foregroundStyle(
                orderBuy
                    ? Color.PrimaryBlack.opacity(0.5) : Color.PrimaryBlack
            )
            .frame(
                maxWidth: .infinity,
                alignment: .topLeading
            )
            .strikethrough(orderBuy)
    }
}

struct OrderTextPreview: PreviewProvider {
    static var previews: some View {

        return OrderText(text: "OrderName", orderBuy: true)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
