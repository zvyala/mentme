//
//  AuthManager.swift
//  ment.me
//
//  Created by Zaynah Alam on 20/04/2024.
//

import Foundation
import FirebaseAuth

class AuthManager: ObservableObject {
    @Published var isLoggedIn = false 
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                completion(error)
            } else {
                self?.isLoggedIn = true
                completion(nil)
            }
        }
    }
}
