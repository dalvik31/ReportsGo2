//
//  OrdersScreen.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 18/11/25.
//

import SwiftUI

struct SalesScreen: View {
    @State private var showingFinances = false
    @State private var showingProfile: Bool = false
    
    var body: some View {

        VStack(spacing: 8) {
            
            NavigationView {
                VStack {
                    Image(systemName: "dollarsign.square")
                    Text("Sales")
                }
              
                .navigationTitle("Sales")
                .navigationBarItems(trailing:HStack(spacing: 24 ){
                    Button {
                        showingProfile = true
                    } label: {
                        Image(systemName: "person.crop.circle")
                    }
                    
                    Button {
                        showingFinances = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
                
                )
                .onAppear {
                    //firestoreManager.getNotes()
                }
                .sheet(isPresented: $showingFinances) {
                    //AddNoteView(firestoreManager: firestoreManager)
                }
                .sheet(isPresented: $showingProfile){
                    ProfileScreen()
                }
            }
                       
         
        }
        
    }
}
