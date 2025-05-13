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
                .position(CGPoint(x: geometry.size.width * 0.9, y: geometry.size.height * 0.1))
                
                VStack {
                    FlashcardView(canFlip: false, flashcard: $currentFlashcardWrapper)
                    
                    if viewModel.currentAnswers.count >= 4 {
                        Grid(horizontalSpacing: 20.0, verticalSpacing: 20.0) {
                            GridRow {
                                Button(action: {
                                    viewModel.answerQuestion(answer: viewModel.currentAnswers[0]) { updated in
                                        currentFlashcardWrapper = updated
                                    }}) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(backgroundColor(for: viewModel.currentAnswers[0]))
                                                .opacity(0.7)
                                            Text(viewModel.currentAnswers[0])
                                                .padding(.vertical, 10)
                                        }
                                    }
                                    .disabled(viewModel.selectedAnswer != nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .buttonStyle(.bordered)
                                
                                Button(action: {
                                    viewModel.answerQuestion(answer: viewModel.currentAnswers[1]) { updated in
                                        currentFlashcardWrapper = updated
                                    }}) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(backgroundColor(for: viewModel.currentAnswers[1]))
                                                .opacity(0.7)
                                            Text(viewModel.currentAnswers[1])
                                                .padding(.vertical, 10)
                                        }
                                    }
                                    .disabled(viewModel.selectedAnswer != nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .buttonStyle(.bordered)
                            }
                            GridRow {
                                Button(action: {
                                    viewModel.answerQuestion(answer: viewModel.currentAnswers[2]) { updated in
                                        currentFlashcardWrapper = updated
                                    }}) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(backgroundColor(for: viewModel.currentAnswers[2]))
                                                .opacity(0.7)
                                            Text(viewModel.currentAnswers[2])
                                                .padding(.vertical, 10)
                                        }
                                    }
                                    .disabled(viewModel.selectedAnswer != nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .buttonStyle(.bordered)
                                
                                Button(action: {
                                    viewModel.answerQuestion(answer: viewModel.currentAnswers[3]) { updated in
                                        currentFlashcardWrapper = updated
                                    }}) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(backgroundColor(for: viewModel.currentAnswers[3]))
                                                .opacity(0.7)
                                            Text(viewModel.currentAnswers[3])
                                                .padding(.vertical, 10)
                                        }
                                    }
                                    .disabled(viewModel.selectedAnswer != nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .buttonStyle(.bordered)
                            }
                            
                        }
                        
                        Button(action: {
                            navigationManager.navigate(to: HomeView.self);
                        })
                        {
                            Image("Home")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 45, height: 45)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .padding(10)
                    }
                }
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
