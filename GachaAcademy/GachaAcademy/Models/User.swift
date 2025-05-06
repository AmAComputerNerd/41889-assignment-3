//
//  User.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 6/5/2025.
//

import Foundation

struct User: Identifiable {
    let id = UUID();
    let name: String;
    let apiKey: String;
    let avatarURL: URL;
    let starredCollections: [FlashcardSet];
    let recentCollections: [FlashcardSet];
    let appliedCosmetics: [Cosmetic];
    
    init(name: String, apiKey: String, avatarURL: URL, starredCollections: [FlashcardSet], recentCollections: [FlashcardSet], appliedCosmetics: [Cosmetic]) {
        self.name = name;
        self.apiKey = apiKey;
        self.avatarURL = avatarURL;
        self.starredCollections = starredCollections;
        self.recentCollections = recentCollections;
        self.appliedCosmetics = appliedCosmetics;
    }
}
