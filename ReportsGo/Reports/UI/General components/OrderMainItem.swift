//
//  AvatarView.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 21/11/25.
//

import SwiftUI

struct OrderMainItem: View {
    let orderMain: OrderMain
 
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(
                        orderMain.getSeasonColor()
                    )
                    .frame(width: 10, height: 10)

                Text(orderMain.nameOrder ?? "")
                    .font(.headline)

                Spacer()
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.PrimaryBlack)
                        .frame(height: 25)

                    Text(orderMain.id.formattedDate(format: Constants.Date.FORMAT_2))
                        .font(.caption)
                        .foregroundColor(Color.PrimaryWhite)
                        .padding(.horizontal, 8)
                }
                .fixedSize()
            }.padding(.bottom, 20)

            HStack {
                ProgressView(
                    value: orderMain.getOrderProgress(),
                    total: 100
                )
                Text(
                    orderMain.orderLists.count == 0
                        ? "\(0) Orders"
                        : "\(orderMain.orderLists.count) Orders"
                )
                .font(.subheadline)
                .padding(.leading,16)

            }
        }
        .background(Color.clear)

        .frame(
            maxWidth: .infinity,
            alignment: .topLeading
        )
    }
}



struct OrderMainItemPreview: PreviewProvider {
    static var previews: some View {
      
        return OrderMainItem(orderMain: OrderMain())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
