//
//  AvatarView.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 21/11/25.
//

import SwiftUI

struct AvatarView: View {
    let initials: String
    //let statusColor: Color
    let size: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) { // Align the status dot to the bottom-trailing corner
            // Avatar circle with initials
            Circle()
                .fill(Color.PrimaryBlack) // Use a dynamic color if desired
                .frame(width: size, height: size)
                .overlay(
                    Text(initials)
                        .font(.system(size: size * 0.4)) // Adjust font size relative to avatar size
                        .fontWeight(.semibold)
                        .foregroundColor(Color.PrimaryWhite)
                )
            
            // Status dot
           /* Circle()
                .fill(statusColor)
                .frame(width: size * 0.35, height: size * 0.35) // Adjust dot size
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2) // Optional white border
                )
                .offset(x: 1, y: 1) // Optional offset for better positioning*/
        }
    }
}
