//
//  HomepageUIView.swift
//  ment.me
//
//  Created by Zaynah Alam on 21/04/2024.
//
import SwiftUI

struct CardView: View {
    var title: String
    var navigateToChat: Bool
    @Binding var showChatView: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue.opacity(0.1))
                .frame(width: 340, height: 200)
                .rotation3DEffect(
                    .degrees(10),
                    axis: (x: -1.0, y: 0.0, z: 0.0)
                )
                .shadow(radius: 5)
                .onTapGesture {
                    if navigateToChat {
                        showChatView = true
                    }
                }

            VStack {
                Spacer()
                Text(title)
                    .font(Font.custom("CoolveticaRG-Regular", size: 30))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
        }
    }
}

struct HomepageUIView: View {
    @State private var showSettings = false
    @State private var showChatView = false

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    showSettings = true
                }) {
                    Image(systemName: "person")
                        .font(.title)
                        .foregroundColor(.orange.opacity(0.3))
                        .padding(.trailing, 20)
                        .padding(.top, 20)
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView()
                }
            }
            Spacer()
            VStack {
                CardView(title: "the base", navigateToChat: true, showChatView: $showChatView)
                CardView(title: "mentor matching", navigateToChat: false, showChatView: $showChatView)
                CardView(title: "the interviewer", navigateToChat: false, showChatView: $showChatView)
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $showChatView) {
            ChatView(viewModel: ChatViewModel())
        }
    }
}

struct HomepageUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageUIView()
    }
}
