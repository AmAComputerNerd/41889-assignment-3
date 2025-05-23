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
    var apiToken: String;
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
    var flashcardBackgroundSpriteName: String? {
        appliedCosmetics.first(where: { $0.type == CosmeticType.FlashcardBackground })?.spriteName;
    }
    
    init(name: String, apiKey: String) {
        self.name = name;
        self.apiToken = apiKey;
        self.ticketCount = 30;
        self.flashcards = FlashcardFolder();
    }
}
