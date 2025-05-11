//
//  CosmeticFactory.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 7/5/2025.
//

import Foundation

class CosmeticFactory {
    public static var threeStars: [() -> Cosmetic] = [
        { Cosmetic("Pink Flashcard", .FlashcardBackground, .Common, "Pink") },
        { Cosmetic("Blue Flashcard", .FlashcardBackground, .Common, "Blue") },
        { Cosmetic("Green Flashcard", .FlashcardBackground, .Common, "Green") },
        { Cosmetic("Nature Background", .Background, .Common, "Nature") },
        { Cosmetic("Space Background", .Background, .Common, "Space") },
        { Cosmetic("Beach Background", .Background, .Common, "Beach") },
        { Cosmetic("Anime Man", .Avatar, .Common, "AnimeMan") },
        { Cosmetic("Anime Woman", .Avatar, .Common, "AnimeWoman") },
        { Cosmetic("Frog", .Avatar, .Common, "Frog") },
        { Cosmetic("Skeleton", .Avatar, .Common, "Skeleton") },
        //{ Cosmetic("Iron Flashcard Border", .FlashcardBorder, .Common, nil) },
    ];
    public static var fourStars: [() -> Cosmetic] = [
        { Cosmetic("Alien Planet Background", .Background, .Epic, "AlienPlanet") },
        { Cosmetic("Minecraft Background", .Background, .Epic, "Minecraft") },
        { Cosmetic("Squiggle Flashcard", .FlashcardBackground, .Epic, "Squiggles") },
        { Cosmetic("Leaf Flashcard", .FlashcardBackground, .Epic, "Leaves") },
        { Cosmetic("Goku", .Avatar, .Epic, "Goku") },
        { Cosmetic("Unicorn", .Avatar, .Common, "Unicorn") },
    ];
    public static var fiveStars: [() -> Cosmetic] = [
        { Cosmetic("Cityscape Background", .Background, .Legendary, "Cityscape") },
        { Cosmetic("Lofi Background", .Background, .Legendary, "Lofi") },
        { Cosmetic("Iron Dagger", .FlashcardBackground, .Legendary, nil) },
        { Cosmetic("Shocked", .Avatar, .Legendary, "Shocked") },
        { Cosmetic("Miku", .Avatar, .Legendary, "Miku") },
    ];
    
    static func createRandomThreeStar() -> Cosmetic {
        return threeStars.randomElement()!();
    }
    
    static func createRandomFourStar() -> Cosmetic {
        return fourStars.randomElement()!();
    }
    
    static func createRandomFiveStar() -> Cosmetic {
        return fiveStars.randomElement()!();
    }
}
