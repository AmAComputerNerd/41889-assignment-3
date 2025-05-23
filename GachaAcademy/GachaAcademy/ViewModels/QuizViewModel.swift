//
//  FlashcardViewModel.swift
//  GachaAcademy
//
//  Created by Tristan Huang on 13/5/2025.
//

import Foundation
import SwiftData

class QuizViewModel: ObservableObject {
    private var dataHelper: DataHelper? = nil
    @Published var user : User? = nil
    @Published var flashcards: [Flashcard] = []
    
    @Published var currentFlashcard: Flashcard? = nil
    @Published var currentAnswers: [String] = []
    @Published var selectedAnswer: String? = nil
    @Published var isGameOver: Bool = false;
    @Published var score: Int = 0;
    @Published var initialCardCount: Int = 0;
    var possibleAnswers: [String] = []
    var correctAnswer: String? = ""
    
    init(flashcards: [Flashcard]) {
        self.flashcards = flashcards;
        self.initialCardCount = flashcards.count
        for flashcard in flashcards {
            possibleAnswers.append(flashcard.back);
        }
        possibleAnswers.shuffle();
        setupQuestion();
    }
    
    func refresh(modelContext: ModelContext) {
        if let dataHelper = dataHelper {
            dataHelper.refreshContext(modelContext: modelContext);
        } else {
            self.dataHelper = DataHelper(modelContext: modelContext);
        }
        self.user = self.dataHelper?.fetchUser();
    }
    
    func setupQuestion() {
        if flashcards.isEmpty
        {
            isGameOver = true;
            return;
        }
        
        currentFlashcard = flashcards.randomElement()!
        flashcards.removeAll { $0 == currentFlashcard }

        correctAnswer = currentFlashcard?.back

        var incorrectAnswers = possibleAnswers.filter { $0 != currentFlashcard!.back }.shuffled()
        
        currentAnswers.removeAll()
        
        for _ in 0...2 {
            currentAnswers.append(incorrectAnswers.removeFirst())
        }
        
        currentAnswers.append(correctAnswer!)
        currentAnswers.shuffle()
    }
    
    func answerQuestion(answer: String, onUpdate: @escaping (Flashcard) -> Void) {
        var delay = 3.0
        selectedAnswer = answer
        
        if correctAnswer == answer && user != nil {
            score += 1
            _ = dataHelper?.updateUser(ticketCount: user!.ticketCount + 1)
            delay = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.setupQuestion()
            self.selectedAnswer = nil
            
            if let newCard = self.currentFlashcard {
                onUpdate(newCard)
            }
        }
    }
}
