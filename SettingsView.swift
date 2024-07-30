//
//  SettingsView.swift
//  ment.me
//
//  Created by Zaynah Alam on 21/04/2024.
//
import SwiftUI
import FirebaseAuth
import FirebaseStorage

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var user: User?
    @State private var isLoggedIn = false
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var savedImageURL: URL? // To store the URL of the saved image

    var body: some View {
        NavigationView {
            ZStack {
                // Your original background view (BackgroundView1 assumed)
                BackgroundView1()

                VStack {
                    Spacer()

                    if let user = user {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill) // Ensure the image fills the frame
                                .frame(width: 150, height: 150)
                                .clipShape(Rectangle())
                        } else if let imageURL = savedImageURL {
                            // Display saved image if available
                            AsyncImage(url: imageURL) { phase in
                                switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill) // Ensure the image fills the frame
                                            .frame(width: 150, height: 150)
                                            .clipShape(Rectangle())
                                    case .failure:
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill) // Ensure the image fills the frame
                                            .frame(width: 150, height: 150)
                                            .clipShape(Rectangle())
                                }
                            }
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill) // Ensure the image fills the frame
                                .frame(width: 150, height: 150)
                                .clipShape(Rectangle())
                        }

                        Button(action: {
                            showingImagePicker = true
                        }) {
                            Text("change profile picture")
                                .font(Font.custom("CoolveticaRG-Regular", size: 18))
                                .foregroundColor(Color.white)
                                .padding()
                                .background(Color.purple.opacity(0.4))
                                .cornerRadius(10)
                        }
                        .padding(.top, 10)

                        Button(action: {
                            saveImageToFirebase()
                        }) {
                            Text("save")
                                .font(Font.custom("CoolveticaRG-Regular", size: 18))
                                .foregroundColor(Color.white)
                                .padding()
                                .background(Color.purple.opacity(0.4))
                                .cornerRadius(10)
                        }
                        .padding(.top, 10)

                        Text("email: \(user.email ?? "Unknown")")
                            .font(Font.custom("CoolveticaRG-Regular", size: 20))
                            .padding(.top, 10) // Adjust vertical padding here
                        // Add more user information here
                    } else {
                        ProgressView("Loading...")
                    }

                    Spacer()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.pink.opacity(0.3))
                },
                trailing: Button(action: {
                    // Log out functions
                    signOut()
                }) {
                    Text("Log Out")
                        .foregroundColor(.pink.opacity(0.3))
                }
            )
            .onAppear {
                fetchUserData()
            }
            .fullScreenCover(isPresented: $isLoggedIn) {
                RegisteredView() // Navigation to registered view when logged out
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $selectedImage)
            }
        }
    }

    func fetchUserData() {
        // Obtain information from Firebase Auth
        if let currentUser = Auth.auth().currentUser {
            // If user is signed in
            self.user = currentUser

            // Check if image is already saved
            checkIfImageExistsInFirebase()
        } else {
            // If no user signed in
            print("No user signed in.")
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut() // Sign out the current user
            isLoggedIn = true // Set isLoggedIn to true to trigger navigation
        } catch {
            print("Error signing out:", error.localizedDescription)
        }
    }

    func saveImageToFirebase() {
        guard let selectedImage = selectedImage,
              let imageData = selectedImage.jpegData(compressionQuality: 0.5) else {
            return
        }

        let storage = Storage.storage()
        let storageRef = storage.reference()
        let profileImagesRef = storageRef.child("profile_images/\(user?.uid ?? "unknown_user_uid").jpg")

        // Upload the file to the path "profile_images/user_uid.jpg"
        let uploadTask = profileImagesRef.putData(imageData, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print("Error uploading image:", error?.localizedDescription ?? "Unknown error")
                return
            }
            // Metadata contains file metadata such as size, content-type, etc.
            print("Image uploaded successfully. Metadata: \(metadata)")
            
            // Once uploaded, update the savedImageURL
            profileImagesRef.downloadURL { (url, error) in
                if let downloadURL = url {
                    savedImageURL = downloadURL
                }
            }
        }
    }
    
    func checkIfImageExistsInFirebase() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let profileImagesRef = storageRef.child("profile_images/\(user?.uid ?? "unknown_user_uid").jpg")

        profileImagesRef.downloadURL { url, error in
            if let downloadURL = url {
                // Image exists, update savedImageURL
                savedImageURL = downloadURL
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
