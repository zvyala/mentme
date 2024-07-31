//
//  RegisteredView.swift
//  ment.me
//
//  Created by Zaynah Alam on 20/04/2024.
//

import SwiftUI
import FirebaseAuth

struct RegisteredView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoggedIn = false
    @State private var showingPasswordResetAlert = false 

    @StateObject var authManager = AuthManager()

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    Text("welcome back, log in to your account")
                        .font(.custom("Coolvetica", size: 36))
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    NavigationLink(destination: CreateAccountView()) {
                        Text("don't have an account? sign up here.")
                            .font(.custom("Coolvetica", size: 18))
                            .foregroundColor(.pink.opacity(0.5))
                    }
                    .padding(.bottom, 20)
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .padding(.bottom, 5)
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.vertical)
                    Button(action: signIn) {
                        Text("Sign in")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color.pink.opacity(0.4))
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .padding(.top, -20)
                    }
                    Button(action: resetPassword) { 
                        Text("Forgot your password?")
                            .foregroundColor(.pink.opacity(0.5))
                    }
                }
                .alert(isPresented: $showingPasswordResetAlert) {
                    Alert(title: Text("Password Reset"),
                          message: Text("Email has been sent."),
                          dismissButton: .default(Text("OK")))
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $isLoggedIn) {
                HomepageUIView()
            }
        }
        .environmentObject(authManager)
    }

    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password"
            return
        }

        authManager.signIn(email: email, password: password) { error in
            if let error = error {
                errorMessage = "Incorrect email or password"
                print("Error signing in:", error.localizedDescription)
            } else {
                print("Sign in successful!")
                isLoggedIn = true
            }
        }
    }

    func resetPassword() {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email address"
            return
        }

        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error sending password reset email:", error.localizedDescription)
                
            } else {
                print("Password reset email sent successfully!")
                showingPasswordResetAlert = true 
            }
        }
    }
}

struct RegisteredView_Previews: PreviewProvider {
    static var previews: some View {
        RegisteredView()
    }
}
