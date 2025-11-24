//
//  OrdersScreen.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 18/11/25.
//

import SwiftUI
import FirebaseAuth

struct ProfileScreen: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State private var showSignOutConfirmation = false

    var body: some View {
        VStack{
            Spacer()
     
            Text("Hello, \(userName)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            AsyncImage(url: authViewModel.currentUser?.photoURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()  .frame(width: 96, height: 96)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 96, height: 96)
                        .clipShape(Circle())
                case .failure:
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 96, height: 96)
                        .foregroundColor(.secondary)
                @unknown default:
                    EmptyView()
                }
            }.padding(.bottom, 10)
            Text("last access")
                .foregroundColor(.secondary)
                .font(.subheadline)
                
            Text(
                formattedDateString(
                    from: authViewModel.currentUser?.metadata.lastSignInDate ?? Date()
                )
            ).padding(.bottom, 20)
               
            VStack(spacing: 16) {
                UserInfoRow(
                    title: "Email",
                    value: authViewModel.currentUser?.email ?? "NotAvailable"
                )
                
                UserInfoRow(
                    title: "SignInMethod",
                    value: authViewModel.signInMethod
                )
                
                if authViewModel.signInMethod == "Email / Password",
                   let isVerified = authViewModel.currentUser?.isEmailVerified {
                    UserInfoRow(
                        title: "EmailVerified",
                        value: isVerified ? "Yes" : "No",
                        valueColor: isVerified ? .green : .red
                    )
                    
                    if !isVerified {
                        Button("SendVerificationEmail") {
                            Task {
                                  await authViewModel.sendEmailVerification()
                            }
                        }
                        .buttonStyle(SecondaryButton())
                 
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
            )
            .padding(.horizontal)
            
            Spacer()
            
            Button("SignOut") {
                Task {
                    showSignOutConfirmation = true
                }
            }.buttonStyle(PrimaryButton())
                .padding()
                .padding(.bottom, 40)
                .confirmationDialog(
                    "ConfirmSignOut",
                    isPresented: $showSignOutConfirmation,
                    titleVisibility: .visible
                ) {
                 
                    Button("Accept") {
                        signOut()
                    }
                }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var userName: String {
        if let displayName = authViewModel.currentUser?.displayName, !displayName.isEmpty {
            return displayName
        }
        let email = authViewModel.currentUser?.email ?? ""
        if let atIndex = email.firstIndex(of: "@") {
            return String(email[..<atIndex])
        } else {
            return email
        }
    }
    
    private func signOut() {
        Task {
            await authViewModel.signOut()
        }
    }
}

func formattedDateString(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium // Example: 15 march 2025
    formatter.timeStyle = .short // Example: 12:00 p.m.
    return formatter.string(from: date)
}

struct UserInfoRow: View {
    let title: String
    let value: String
    var valueColor: Color = .primary
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(title))
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .fontWeight(.medium)
                .foregroundColor(valueColor)
        }
    }
}


struct ProfileScreenPreview: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
 
    }
}
