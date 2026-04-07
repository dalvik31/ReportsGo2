//
//  ContentView.swift
//  DalvikNotes
//
//  Created by Emmanuel Pacheco on 11/11/25.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var ordersMainViewModel: OrdersMainViewModel
    
        
    private var isPersistedLogin: Bool {
        UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
        
    var body: some View {
        NavigationStack {
       
            Group {
                if authViewModel.state == .signedIn ||
                    (isPersistedLogin && authViewModel.currentUser != nil) {
                    HomeScreen()
                } else {
                    AccountScreen()
                }
  
            }
            .animation(.easeInOut, value: authViewModel.state)
        }
        .overlay {
      
            if authViewModel.isLoading {
                LoadingView()
            }
        }
        .alert(item: errorBinding) { authError in
            Alert(
                title: Text("Error"),
                message: Text(
                    authError.errorDescription ?? "An unknown error occurred"
                ),
                dismissButton: .default(Text("Accept"))
            )
        }
        .alert(item: orderErrorBinding) { OrdersError in
            Alert(
                title: Text("Error"),
                message: Text(
                    OrdersError.errorDescription ?? "An unknown error occurred"
                ),
                dismissButton: .default(Text("Accept"))
            )
        }
    }
        
   
    private var errorBinding: Binding<IdentifiableError?> {
        Binding<IdentifiableError?>(
            get: {
                guard let error = authViewModel.error else { return nil }
    
                return IdentifiableError(error: error)
            },
            set: { _ in authViewModel.error = nil }
        )
    }
    
    private var orderErrorBinding: Binding<IdentifiableOrderError?> {
        Binding<IdentifiableOrderError?>(
            get: {
          
                guard let error = ordersMainViewModel.error else { return nil }
                return IdentifiableOrderError(error: error)
            },
            set: { _ in ordersMainViewModel.error = nil }
        )
    }
}


struct IdentifiableError: Identifiable {
    let id = UUID()
    let error: AuthError
    
    var errorDescription: String? {
        error.localizedDescription
    }
}

struct IdentifiableOrderError: Identifiable {
    let id = UUID()
    let error: OrdersError
    
    var errorDescription: String? {
        error.localizedDescription
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(AuthenticationViewModel(
            authRepository: FirebaseAuthRepository()
        )
        )
   
    }
  
}
