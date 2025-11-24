//
//  LoginView.swift
//  DalvikNotes
//
//  Created by Emmanuel Pacheco on 13/11/25.
//

import SwiftUI

struct AccountScreen: View {
    @State private var email: String = "eeph34@gmail.com"
    @State private var password: String = "123456"
    @State private var showResetPasswordAlert: Bool = false
    @State private var resetPasswordEmail: String = ""
    @State private var showPasswordResetConfirmation: Bool = false
    @FocusState private var emailIsFocused: Bool
    @FocusState private var passwordIsFocused: Bool
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 5) {
                Image(.logo)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 250, height: 300)
                    .colorMultiply(Color.PrimaryBlack)
            }
        
            VStack(spacing: 0) {
                TextField("Email", text: $email)
                    .withLoginStyles()
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .submitLabel(.next)
                    .focused($emailIsFocused)
                    .onSubmit {
                        emailIsFocused = false
                        passwordIsFocused = true
                    }
                
                SecureField("Password", text: $password)
                    .withSecureFieldStyles()
                    .submitLabel(.go)
                    .focused($passwordIsFocused)
                    .onSubmit {
                        signIn()
                    }
                
                // Forgot Password Link
                HStack {
                    Spacer()
                    Button {
                        showResetPasswordAlert = true
                    } label: {
                        Text("ForgotPassword")
                            .foregroundColor(Color.PrimaryBlack)
                            .font(.footnote)
                    }
                }
                .padding(.bottom, 20)
                
                // Error Display
                /*if let error = authViewModel.error {
                 Text(error.localizedDescription)
                 .font(.footnote)
                 .foregroundColor(.red)
                 .padding(.bottom, 12)
                 .transition(.opacity)
                 }*/
                
                // Sign In Button
                Button("SignIn") {
                    signIn()
                }
                .buttonStyle(PrimaryButton())
                .disabled(email.isEmpty || password.isEmpty)
                .padding(.bottom, 15)
                
                Button("SignUp") {
                    print("Button tapped!")
                }
                .buttonStyle(SecondaryButton())
                .disabled(email.isEmpty || password.isEmpty)
                
                /*Button(action: { /* action */ }) {
                 Text("Save") // This will be ignored if you pass title + systemIconName to the style
                 }
                 .buttonStyle(SecondaryButton(title: "SignInWithGoogle", iconName: "GoogleIcon"))*/
                /*Button("SignUp") {
                 print("Button tapped!")
                 }
                 .buttonStyle(SecondaryButton())
                 .disabled(email.isEmpty || password.isEmpty)*/
                /*Button(action: signIn) {
                 /*if authViewModel.isLoading {
                  ProgressView()
                  .tint(.white)
                  } else {*/
                 Text("SignIn")
                 .foregroundColor(.PrimaryWhite)
                 .font(.headline)
                 .frame(maxWidth: .infinity)
                 .padding()
                 .background(Color.PrimaryBlack)
                 .cornerRadius(10)
                 //}
                 }*/
            
                
                
                // Sign Up Button
                /*Button(action: signUp) {
                 Text("SignUp")
                 .foregroundStyle(
                 Color.PrimaryBlack
                 ) // Change text color to white
                 .font(.headline)
                 .frame(maxWidth: .infinity)
                 .padding()
                 .cornerRadius(10)
                 }
                 .disabled(
                 email.isEmpty || password.isEmpty /*|| authViewModel.isLoading*/
                 )*/
            }
            .padding(.horizontal)
            
            // OR Divider
            HStack {
                VStack { Divider() }
                Text("o")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                VStack { Divider() }
            }
            .padding(.vertical, 30)
            .padding(.horizontal)
            
            // Social Login Options - Centered in remaining space
            Spacer()
            
            Button("SignUp") {
                Task { await signInWithGoogle() }
            }
            .buttonStyle(
                PrimaryIconButton(
                    title: "SignInWithGoogle",
                    iconName: "GoogleIcon"
                )
            )
            .disabled(email.isEmpty || password.isEmpty)
            .padding()
            
        
            /*Button("SignUp") {
             print("Button tapped!")
             }
             .buttonStyle(SecondaryButton())
             .disabled(email.isEmpty || password.isEmpty)*/
            
            //SocialLoginView()
            
            Spacer()
        }
        .padding(.horizontal)
        .alert("ResetPassword", isPresented: $showResetPasswordAlert) {
            TextField("enterEmail", text: $resetPasswordEmail)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            Button("Cancel", role: .cancel) {}
            
            Button("ResetPassword") {
                Task {
                    //await authViewModel.sendPasswordReset(email: resetPasswordEmail)
                    showPasswordResetConfirmation = true
                }
            }
        } message: {
            Text(
                "EnterYourEmailToSendResetPasswordEmail"
            )
        }
        .alert(
            "ResetEmailSent",
            isPresented: $showPasswordResetConfirmation
        ) {
            Button("Accept", role: .cancel) {
                
            }
        } message: {
            Text("CheckEmail")
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    // Helper methods
    private func signIn() {
        Task {
            await authViewModel.login(with: .emailAndPassword(
                email: email,
                password: password
            ))
        }
    }
    
    private func signUp() {
        Task {
            do {
                /*  try await authViewModel.signUp(
                 email: email,
                 password: password
                 )*/
            } catch {
                // Error handling is already done in the ViewModel
            }
        }
    }
    
    private func signInWithGoogle() async {
        await authViewModel.login(with: .signInWithGoogle)
    }
}



struct Login_Previews: PreviewProvider {
    static var previews: some View {
        AccountScreen()
        /* .environmentObject(AuthenticationViewModel(
         authRepository: FirebaseAuthRepository()
         ))*/
    }
}
