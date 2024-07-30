//
//  MessageView.swift
//  ment.me
//
//  Created by Zaynah Alam on 30/04/2024.
//
import SwiftUI

struct MessageView: View {
    let chatMessage: ChatMessage
    let isCurrentUser: Bool
    let userImage: Image
    
    var body: some View {
        VStack {
            HStack {
                if !isCurrentUser {
                    userImage
                        .resizable()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                } else {
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(chatMessage.senderName)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(chatMessage.text)
                        .padding(8)
                        .background(isCurrentUser ? Color.blue : Color.gray.opacity(0.1))
                        .foregroundColor(isCurrentUser ? .white : .black)
                        .cornerRadius(8)
                }
                
                if isCurrentUser {
                    userImage
                        .resizable()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                } else {
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
    }
}
