//
//  User.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 6/5/2025.
//

import Foundation
import SwiftData

@Model
class User: Identifiable {
    var id = UUID();
    var name: String;
    var apiKey: String;
    var ticketCount: Int;
    @Relationship var flashcards: FlashcardFolder;
    @Relationship var starredCollections: [FlashcardSet] = [];
    @Relationship var recentCollections: [FlashcardSet] = [];
    @Relationship var appliedCosmetics: [Cosmetic] = [];
    
    var avatarSpriteName: String? {
        appliedCosmetics.first(where: { $0.type == CosmeticType.Avatar })?.spriteName;
    }
    var backgroundSpriteName: String? {
        appliedCosmetics.first(where: { $0.type == CosmeticType.Background })?.spriteName;
    }
    // TODO: Implement Flashcard sprites when Flashcards are successfully implemented.
    var flashcardBackgroundSpriteName: String? {
        appliedCosmetics.first(where: { $0.type == CosmeticType.FlashcardBackground })?.spriteName;
    }
    var flashcardBorderSpriteName: String? {
        appliedCosmetics.first(where: { $0.type == CosmeticType.FlashcardBorder })?.spriteName;
    }
    
    init(name: String, apiKey: String) {
        self.name = name;
        self.apiKey = apiKey;
        self.ticketCount = 0;
        self.flashcards = FlashcardFolder();
    }
}
