//
//  OrdersScreen.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 18/11/25.
//

import SwiftUI

struct ClientsScreen: View {
    @EnvironmentObject var clientsViewModel: ClientsViewModel
    @State private var showingAddClient = false
    @State private var showingProfile: Bool = false
    var body: some View {

        VStack(spacing: 8) {

            NavigationView {
                List {
                    ForEach(clientsViewModel.clients) { client in
                        // Main container (the card itself)
                        HStack(spacing: 12) {
                            // Left side: Avatar with initials and status dot
                            AvatarView(initials: client.clientFullName.initials, statusColor: client.getClientDotBackground(), size: 50)
                            // Center: Name text
                            Text(client.clientFullName)
                                .font(.body)
                                .foregroundColor(Color.PrimaryBlack)

                            Spacer()  // Pushes content to the edges

                            // Right side: Phone number badge
                            if !client.clientPhoneNumber.isEmpty {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.PrimaryBlack)
                                        .frame(height: 30)

                                    Text(client.clientPhoneNumber)
                                        .font(.caption)
                                        .foregroundColor(Color.PrimaryWhite)
                                        .padding(.horizontal, 8)
                                }
                                .fixedSize()  // Prevents the ZStack from expanding more than necessary
                            }
                         
                        }
            
                  

                    }
                }

                .navigationTitle("Clients")
                .navigationBarItems(
                    trailing: HStack(spacing: 24) {
                        Button {
                            showingProfile = true
                        } label: {
                            Image(systemName: "person.crop.circle")
                        }

                        Button {
                            showingAddClient = true
                        } label: {
                            Image(systemName: "plus")
                        }

                    }

                )
                .onAppear {
                    getClients()
                }
                .sheet(isPresented: $showingAddClient) {
                    //AddNoteView(firestoreManager: firestoreManager)
                }
                .sheet(isPresented: $showingProfile) {
                    ProfileScreen()
                }
                .overlay {

                    if clientsViewModel.isLoading {
                        LoadingView()
                    }
                }

            }

        }

    }
    private func getClients() {
        Task {
            await clientsViewModel.getClients()
        }

    }

}
