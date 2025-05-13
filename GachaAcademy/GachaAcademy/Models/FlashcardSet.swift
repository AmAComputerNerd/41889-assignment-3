//
//  FlashcardSet.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 6/5/2025.
//

import Foundation
import SwiftData

@Model
class FlashcardSet: Identifiable, ObservableObject {
    var id: UUID = UUID();
    var name: String;
    @Relationship var flashcards: [Flashcard];
    
    init(name: String, flashcards: [Flashcard] = []) {
        self.name = name;
        self.flashcards = flashcards;
    }
}
