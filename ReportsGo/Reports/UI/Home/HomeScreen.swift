//
//  HomeScreen.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 15/11/25.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State private var showSignOutConfirmation = false
    @State private var showingAddNote = false
    
    var body: some View {
        
        TabView {
            OrdersScreen()
                .tabItem {
                    Image(systemName: "text.justify")
                    Text("Orders")
                }
           ClientsScreen()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Clients")
                }
            ProductsScreen()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Products")
                }
            SalesScreen()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Sales")
                }
        }
    }
}

                
                
