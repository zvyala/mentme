//
//  FirebaseManager.swift
//  ment.me
//
//  Created by Zaynah Alam on 22/04/2024.
//
import Foundation
import FirebaseFirestore //importing firebase sdk
import FirebaseAuth
import Combine

class FirebaseManager: ObservableObject {
    @Published var messages: [Message] = []
    private var cancellables: Set<AnyCancellable> = []

    private let db = Firestore.firestore()
    private let messagesRef: CollectionReference

    init() {
        messagesRef = db.collection("messages")

        messagesRef.addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error listening for messages: \(error.localizedDescription)")
                return
            }

            self.messages = querySnapshot?.documents.compactMap { document in
                try? document.data(as: Message.self)
            } ?? []
        }
    }

    func sendMessage(_ message: Message) {
        do {
            _ = try messagesRef.addDocument(from: message) { error in
                if let error = error {
                    print("Error sending message: \(error.localizedDescription)")
                } else {
                    print("Message sent successfully")
                }
            }
        } catch {
            print("Error sending message: \(error.localizedDescription)")
        }
    }
}

