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

                        HStack(spacing: 12) {

                            AvatarView(
                                initials: client.clientFullName.initials,
                                size: 50
                            )

                            VStack {
                                HStack {
                                    Text(client.clientFullName)
                                        .font(.subheadline)
                                        .foregroundColor(
                                            Color.PrimaryBlack
                                        )

                                        .frame(
                                            maxWidth: .infinity,
                                            alignment: .leading
                                        )
                                }
                                Text(
                                    "\(client.debt ?? 0, format: .currency(code: "MXN"))"
                                )
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(
                                    client.getClientCreditLimitRiskColor()
                                )
                                .frame(maxWidth: .infinity, alignment: .leading)

                            }
                            if !client.clientPhoneNumber.isEmpty {
                                Button("SignUp") {
                                    //Task { await signInWithGoogle() }
                                }
                                .buttonStyle(
                                    PrimaryIconButton(
                                        systemName: "phone",
                                        isSecondaryButton: true
                                    )
                                ).frame(width: 50, height: 50)
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
