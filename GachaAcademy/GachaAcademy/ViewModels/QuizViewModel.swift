//
//  FlashcardViewModel.swift
//  GachaAcademy
//
//  Created by Kyan Grimm on 12/5/2025.
//

import Foundation
import SwiftData

class QuizViewModel: ObservableObject {
    private var dataHelper: DataHelper? = nil
    @Published var user : User? = nil
    @Published var Flashcards: [Flashcard] = []
    
    @Published var currentFlashcard: Flashcard? = nil
    @Published var currentAnswers: [String] = []
    @Published var selectedAnswer: String? = nil
    var possibleAnswers: [String] = []
    var correctAnswer: String? = ""
    
    init() {
        Flashcards = [Flashcard(front: "A", back: "A"), Flashcard(front: "B", back: "B"), Flashcard(front: "C", back: "C"), Flashcard(front: "D", back: "D"), Flashcard(front: "E", back: "E"), Flashcard(front: "F", back: "F")]
        // Replace with the get request
        
        for flashcard in Flashcards {
            possibleAnswers.append(flashcard.back)
        }
        possibleAnswers.shuffle()
        setupQuestion()
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
        currentFlashcard = Flashcards.randomElement()!
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
        selectedAnswer = answer
        if correctAnswer == answer {
            user?.ticketCount += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.setupQuestion()
            self.selectedAnswer = nil
            
            if let newCard = self.currentFlashcard {
                onUpdate(newCard)
            }
        }
    }
}
