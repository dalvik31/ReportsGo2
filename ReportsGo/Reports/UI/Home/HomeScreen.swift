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
            OrdersMainSreen()
                .tabItem {
                    Image(systemName: "text.justify")
                    Text("Orders")
                }
                .navigationViewStyle(.stack)
           ClientsScreen()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Clients")
                } .navigationViewStyle(.stack)
            ProductsScreen()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Products")
                } .navigationViewStyle(.stack)
            SalesScreen()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Sales")
                } .navigationViewStyle(.stack)
        }
    }
}

                
                
