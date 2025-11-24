//
//  AuthenticationViewModel.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 15/11/25.
//

import SwiftUI
import FirebaseAuth
import Combine

@MainActor
class AuthenticationViewModel: ObservableObject {
    
    @Published var state: SignInState = .signedOut
    @Published var currentUser: User?
    @Published var error: AuthError?
    @Published var signInMethod: String = "Unknown"
    @Published var isLoading: Bool = false
    
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol? = nil) {
        let repository = authRepository ?? FirebaseAuthRepository()
        self.authRepository = repository
        checkAuthenticationState()
        setupAuthStateListener()
    }
    

    @MainActor
    private func setupAuthStateListener() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else { return }
            assert(Thread.isMainThread)
            
            self.currentUser = user
            
            self.state = user != nil ? .signedIn : .signedOut
            
            if let user = user {
                self.determineSignInMethod(for: user)
            }
        }
    }
    
    deinit {
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    private func determineSignInMethod(for user: User) {
        if let providerData = user.providerData.first?.providerID {
            switch providerData {
            case "google.com":
                signInMethod = "Google"
            case "apple.com":
                signInMethod = "Apple"
            case "password":
                signInMethod = "Email / Password"
            default:
                signInMethod = providerData
            }
        }
    }
    
    private func checkAuthenticationState() {
        self.currentUser = authRepository.getCurrentUser()
        
        if currentUser != nil {
            self.state = .signedIn
            
            if let user = currentUser {
                determineSignInMethod(for: user)
            }
        } else {
            self.state = .signedOut
        }
    }
    
    func login(with loginOption: LoginOption) async {
        isLoading = true
        error = nil
        
        defer { isLoading = false }
        
        do {
            switch loginOption {
            case .signInWithApple:
                try await signInWithApple()
            case let .emailAndPassword(email, password):
                try await signInWithEmail(email: email, password: password)
            case .signInWithGoogle:
                try await signInWithGoogle()
            }
            

            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            
        } catch let authError as AuthError {
            self.error = authError
        } catch {
            self.error = .signInFailed(description: error.localizedDescription)
        }
    }
    
    func signInWithEmail(email: String, password: String) async throws {
        self.currentUser = try await authRepository
            .signInWithEmail(email: email, password: password)
    }
    
    func signInWithGoogle() async throws {
        self.currentUser = try await authRepository.signInWithGoogle()
    }
    
    func signInWithApple() async throws {
        /*return try await withCheckedThrowingContinuation { continuation in
         authRepository.signInWithApple { result in
         switch result {
         case .success(let user):
         self.currentUser = user
         continuation.resume()
         case .failure(let error):
         continuation.resume(throwing: error)
         }
         }
         }*/
    }
    
    func sendEmailVerification() async {
        isLoading = true
        error = nil
        
        do {
            try await authRepository.sendEmailVerification()
        } catch {
            self.error = error as? AuthError
        }
        
        isLoading = false
    }
    
    
    func signOut() async {
        isLoading = true
        error = nil
        
        do {
            try await authRepository.signOut()
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            state = .signedOut
            currentUser = nil
        } catch {
            self.error = error as? AuthError ?? 
                .signOutFailed(description: error.localizedDescription)
        }
        
        isLoading = false
    }
}

