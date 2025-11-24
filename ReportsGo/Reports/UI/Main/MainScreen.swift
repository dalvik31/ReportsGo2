//
//  DalvikNotesApp.swift
//  DalvikNotes
//
//  Created by Emmanuel Pacheco on 11/11/25.
//

import Firebase
import FirebaseCore
import GoogleSignIn
import SwiftData
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()

        return true
    }
}

@main
struct MainScreen: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject var authViewModel = AuthenticationViewModel(
        authRepository: FirebaseAuthRepository()
    )
    @StateObject var ordersMainViewModel = OrdersMainViewModel(
        ordersRepository: OrdersRepository()
    )

    @StateObject var clientOrdersMainViewModel = ClientsViewModel(
        clientsRepository: ClientsRepository()
    )

    @StateObject var productsMainViewModel: ProductsViewModel =
        ProductsViewModel(
            productsRepository: ProductsRepository()
        )
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(authViewModel).environmentObject(
                ordersMainViewModel
            ).environmentObject(clientOrdersMainViewModel).environmentObject(
                productsMainViewModel
            ).onOpenURL { url in
                GIDSignIn.sharedInstance.handle(url)
            }
        }
    }
}
