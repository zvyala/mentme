//
//  QuizView.swift
//  ment.me
//
//  Created by Zaynah Alam on 21/04/2024.
//

import SwiftUI

struct QuizView: View {
    @State private var selectedAnswers: [String] = [] 
    @State private var navigateToHomepage = false

    let questions = [
        ("Are you a sixth form student, university student or apprentice?", 40),
        ("What industry would you like to/do you work in?", 30),
        ("Would you like to receive mentoring or become a mentor?", 35)
    ]

    let answers = [
        ["Sixth Form", "University", "Apprentice"],
        ["Technology", "Healthcare and Medicine", "Finance and Economics", "Business and Management", "Law and Social Sciences", "Architecture and Design", "Humanities and Arts"],
        ["Receive mentoring", "Become a mentor"]
    ]

    @State private var selectedQuestionIndex = 0

//UI for quiz view
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()

                VStack {
                    Spacer()

                    Text(questions[selectedQuestionIndex].0)
                        .font(Font.custom("CoolveticaRG-Regular", size: CGFloat(questions[selectedQuestionIndex].1)))
                        .padding()
                        .multilineTextAlignment(.center)

                    VStack(spacing: 10) {
                        ForEach(answers[selectedQuestionIndex], id: \.self) { answer in
                            Button(action: {
                                selectAnswer(answer)
                            }) {
                                Text(answer)
                                    .font(Font.custom("CoolveticaRG-Regular", size: 20))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedAnswers.contains(answer) ? Color(red: 255/255, green: 208/255, blue: 217/255) : Color(red: 150/255, green: 200/255, blue: 255/255))
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding()

                    Spacer()

                    Button(action: nextButtonAction) {
                        Text("Next")
                            .font(Font.custom("CoolveticaRG-Regular", size: 20))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(red: 255/255, green: 208/255, blue: 217/255))
                            .cornerRadius(8)
                    }
                    .padding()
                    .disabled(selectedAnswers.isEmpty)
                    .padding(.top)
                }
                .padding()
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $navigateToHomepage) {
                HomepageUIView()
            }
        }
    }

    func selectAnswer(_ answer: String) {
        if selectedQuestionIndex == 1 { 
            if selectedAnswers.contains(answer) {
                selectedAnswers.removeAll { $0 == answer }
            } else {
                selectedAnswers.append(answer)
            }
        } else { 
            selectedAnswers = [answer]
        }
    }

    func nextButtonAction() {
        if selectedQuestionIndex < questions.count - 1 {
            selectedQuestionIndex += 1
            selectedAnswers = [] 
        } else {
            navigateToHomepage = true
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
