import SwiftUI

struct AIChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var inputText: String = ""
    @State private var contextText: String = "Provide a relevant context here."

    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages) { message in
                    Text("\(message.senderName): \(message.text)")
                        .padding()
                        .background(message.senderName == "You" ? Color.blue : Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                }
            }
            .padding(.top)

            HStack {
                TextField("Enter message...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)

                Button(action: sendMessage) {
                    Text("Send")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.trailing)
                }
            }
            .padding(.bottom)
        }
        .navigationBarTitle("AI Chat", displayMode: .inline)
    }

    private func sendMessage() {
        guard !inputText.isEmpty else { return }

        // Send user message
        let userMessage = ChatMessage(senderName: "You", text: inputText)
        viewModel.messages.append(userMessage)

        // Fetch AI response with context
        viewModel.sendMessage(inputText, context: contextText)
        inputText = ""
    }
}

struct AIChatView_Previews: PreviewProvider {
    static var previews: some View {
        AIChatView()
    }
}
