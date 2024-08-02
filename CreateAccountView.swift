//
//  CreateAccountView.swift
//  ment.me
//
//  Created by Zaynah Alam on 19/04/2024.
//
// CreateAccountView.swift

// CreateAccountView.swift

import SwiftUI
import FirebaseAuth

struct CreateAccountView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var dateOfBirth = Date()
    @State private var errorMessage = "" 
    @State private var navigateToQuiz = false 
    @State private var navigateToRegisteredView = false 
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView() 

                VStack {
                    Text("create new account")
                        .font(.custom("Coolvetica", size: 36))
                        .padding(.top, 40)
                        .padding(.bottom, 10) 
                    Button(action: {
                        
                        navigateToRegisteredView = true
                    }) {
                        Text("already have an account? log in here.")
                            .font(.custom("Coolvetica", size: 18))
                            .foregroundColor(.pink.opacity(0.5))
                    }
                    .padding(.bottom, 20) // Same spacing as after title

                    TextField("Name", text: $name)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .autocapitalization(.none)

                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .padding(.bottom, 5) 

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .autocapitalization(.none)

                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)

                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.vertical)

                    Button(action: signUp) {
                        Text("Sign up")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color.pink.opacity(0.4))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    .padding(.top, -20)
                }
                .padding()
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $navigateToQuiz) {
                QuizView() 
            }
            .fullScreenCover(isPresented: $navigateToRegisteredView) {
                RegisteredView() 
            }
        }
    }

    func signUp() {
        
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter name, email, and password"
            return
        }

        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
               
                errorMessage = "Error signing up: \(error.localizedDescription)"
                print(errorMessage)
            } else {
                
                print("Sign up successful!")
                navigateToQuiz = true
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
