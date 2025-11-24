//
//  AuthRepository.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 15/11/25.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices



// Implementation of the repository
class FirebaseAuthRepository: NSObject, AuthRepositoryProtocol {
    
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func signInWithEmail(email: String, password: String) async throws -> User {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            return result.user
        } catch {
            throw AuthError.signInFailed(description: error.localizedDescription)
        }
    }
    
    func signUpWithEmail(email: String, password: String) async throws -> User {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            // Send email verification
            try await result.user.sendEmailVerification()
            return result.user
        } catch {
            throw AuthError.signUpFailed(description: error.localizedDescription)
        }
    }
    
    func signOut() async throws {
        // Sign out from Google if applicable
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
        } catch {
            throw AuthError.signOutFailed(description: error.localizedDescription)
        }
    }
    
    func sendEmailVerification() async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        
        try await user.sendEmailVerification()
    }
    
    
    func signInWithGoogle() async throws -> User {
        // Check for existing sign-in
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            do {
                let result = try await GIDSignIn.sharedInstance.restorePreviousSignIn()
                return try await authenticateGoogleUser(for: result)
            } catch {
                throw AuthError.signInFailed(description: error.localizedDescription)
            }
        } else {
            // Get the root view controller
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootViewController = windowScene.windows.first?.rootViewController else {
                throw AuthError.noRootViewController
            }
            
            do {
                let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
                return try await authenticateGoogleUser(for: result.user)
            } catch {
                throw AuthError.signInFailed(description: error.localizedDescription)
            }
        }
    }
    
    private func authenticateGoogleUser(for user: GIDGoogleUser?) async throws -> User {
        guard let idToken = user?.idToken?.tokenString else {
            throw AuthError.invalidCredential
        }
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: user?.accessToken.tokenString ?? ""
        )
        
        do {
            let result = try await Auth.auth().signIn(with: credential)
            return result.user
        } catch {
            throw AuthError.signInFailed(description: error.localizedDescription)
        }
    }
    
}
