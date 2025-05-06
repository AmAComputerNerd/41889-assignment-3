//
//  FlashcardSet.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 6/5/2025.
//

import Foundation

class FlashcardSet: Identifiable {
    // TODO: Overhaul in BTS-18 / other flashcard related tasks.
    // Temporary model code for BTS23 - Profile page basic mvvm structure
    let id: UUID = UUID();
    let name: String;
    let flashcards: [Flashcard];
    
    init(name: String, flashcards: [Flashcard]) {
        self.name = name;
        self.flashcards = flashcards;
    }
}
