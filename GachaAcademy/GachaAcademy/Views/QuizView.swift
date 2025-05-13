//
//  QuizView.swift
//  GachaAcademy
//
//  Created by Tristan Huang on 12/5/2025.
//

import SwiftUI

struct QuizView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel: QuizViewModel;
    @EnvironmentObject private var navigationManager: NavigationManager

    // Local state to mirror the current flashcard
    @State private var currentFlashcardWrapper: Flashcard = Flashcard(front: "", back: "")
    
    init(flashcardSet: FlashcardSet) {
        self._viewModel = StateObject(wrappedValue: QuizViewModel(flashcards: flashcardSet.flashcards));
    }

    var body: some View {
            GeometryReader { geometry in
                ZStack {
                    BackgroundView(spriteName: viewModel.user?.backgroundSpriteName)
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                navigationManager.navigate(to: ProfileView.self)
                            }) {
                                if let avatar = viewModel.user?.avatarSpriteName {
                                    Image(avatar)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 45, height: 45)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.secondary, lineWidth: 2))
                                } else {
                                    Circle()
                                        .fill(Color.gray)
                                        .frame(width: 45, height: 45)
                                }
                            }
                            .padding()
                        }

                        Spacer()

                        if viewModel.isGameOver {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .overlay(
                                    VStack(spacing: 10) {
                                        Text("Game Complete!")
                                            .font(.title)
                                        
                                        Text("You scored \(viewModel.score) out of \(viewModel.initialCardCount)")
                                    }
                                )
                                .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.4)
                        } else {
                            VStack(spacing: 20) {
                                FlashcardView(canFlip: false, flashcard: $currentFlashcardWrapper)
                                
                                if viewModel.currentAnswers.count >= 4 {
                                    VStack(spacing: 10) {
                                        ForEach(0..<2) { row in
                                            HStack(spacing: 20) {
                                                ForEach(0..<2) { col in
                                                    let index = row * 2 + col
                                                    Button(action: {
                                                        viewModel.answerQuestion(answer: viewModel.currentAnswers[index]) { updated in
                                                            currentFlashcardWrapper = updated
                                                        }
                                                    }) {
                                                        ZStack {
                                                            RoundedRectangle(cornerRadius: 10)
                                                                .fill(backgroundColor(for: viewModel.currentAnswers[index]))
                                                                .opacity(0.7)
                                                            Text(viewModel.currentAnswers[index])
                                                                .padding(.vertical, 10)
                                                        }
                                                    }
                                                    .disabled(viewModel.selectedAnswer != nil)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                    .buttonStyle(.bordered)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Spacer()

                        Button(action: {
                            navigationManager.navigate(to: HomeView.self)
                        }) {
                            Image("Home")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 45, height: 45)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .padding(.bottom, 20)
                    }
                    .frame(width: geometry.size.width * 0.9)
                    .padding(.vertical)
                }
            }
            .onAppear {
                viewModel.refresh(modelContext: modelContext)
                if let flashcard = viewModel.currentFlashcard {
                    currentFlashcardWrapper = flashcard
                }
            }
        }
    
    func backgroundColor(for answer: String) -> Color {
        guard let selected = viewModel.selectedAnswer else {
            return Color.white
        }

        if answer == viewModel.correctAnswer {
            return Color.green
        } else if answer == selected {
            return Color.red
        } else {
            return Color.white
        }
    }

}
