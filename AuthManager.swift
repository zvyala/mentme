//
//  AuthManager.swift
//  ment.me
//
//  Created by Zaynah Alam on 20/04/2024.
//

import Foundation
import FirebaseAuth

class AuthManager: ObservableObject {
    @Published var isLoggedIn = false // State variable to track login status

    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                // Handle sign in error
                completion(error)
            } else {
                // Sign in successful
                self?.isLoggedIn = true
                completion(nil)
            }
        }
    }
}
