//
//  LoginOption.swift
//  ReportsGo
//
//  Created by Emmanuel Pacheco on 15/11/25.
//
enum LoginOption {
    case signInWithApple
    case signInWithGoogle
    case emailAndPassword(email: String, password: String)
}
