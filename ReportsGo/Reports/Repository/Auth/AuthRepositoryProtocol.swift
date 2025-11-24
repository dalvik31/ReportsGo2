//
//  AuthRepositoryProtocol.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 21/11/25.
//

import FirebaseAuth

// Authentication repository protocol
protocol AuthRepositoryProtocol {
    func getCurrentUser() -> User?
    func signInWithEmail(email: String, password: String) async throws -> User
    func signUpWithEmail(email: String, password: String) async throws -> User
    func signOut() async throws
    func sendEmailVerification() async throws
    func signInWithGoogle() async throws -> User
    /*
     func signInWithApple(onCompletion: @escaping (Result<User, Error>) -> Void)
   
     func sendPasswordReset(email: String) async throws
     
     func updateUserProfile(displayName: String?, photoURL: URL?) async throws
     func deleteAccount() async throws
     func reauthenticate(email: String, password: String) async throws
     func updateEmail(email: String) async throws
     func updatePassword(password: String) async throws*/
}
