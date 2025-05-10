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
    var avatarURL: String?;
    var ticketCount: Int;
    @Relationship var flashcards: FlashcardFolder;
    @Relationship var starredCollections: [FlashcardSet] = [];
    @Relationship var recentCollections: [FlashcardSet] = [];
    @Relationship var appliedCosmetics: [Cosmetic] = [];
    
    init(name: String, apiKey: String, avatarURL: String?) {
        self.name = name;
        self.apiKey = apiKey;
        self.avatarURL = avatarURL;
        self.ticketCount = 0;
        self.flashcards = FlashcardFolder();
    }
}
