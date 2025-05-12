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
        { Cosmetic("Orange Flashcard", .FlashcardBackground, .Common, "Orange") },
        { Cosmetic("Red Flashcard", .FlashcardBackground, .Common, "Red") },
        { Cosmetic("Purple Flashcard", .FlashcardBackground, .Common, "Purple") },
        { Cosmetic("Yellow Flashcard", .FlashcardBackground, .Common, "Yellow") },
        { Cosmetic("Nature Background", .Background, .Common, "Nature") },
        { Cosmetic("Space Background", .Background, .Common, "Space") },
        { Cosmetic("Beach Background", .Background, .Common, "Beach") },
        { Cosmetic("Hive Background", .Background, .Common, "Hive") },
        { Cosmetic("Waves Background", .Background, .Common, "Waves") },
        { Cosmetic("Anime Man", .Avatar, .Common, "AnimeMan") },
        { Cosmetic("Anime Woman", .Avatar, .Common, "AnimeWoman") },
        { Cosmetic("Frog", .Avatar, .Common, "Frog") },
        { Cosmetic("Skeleton", .Avatar, .Common, "Skeleton") },
        { Cosmetic("Unicorn", .Avatar, .Common, "Unicorn") },
        { Cosmetic("Cat", .Avatar, .Common, "Cat") },
        { Cosmetic("Dog", .Avatar, .Common, "Dog") },
    ];
    public static var fourStars: [() -> Cosmetic] = [
        { Cosmetic("Alien Planet Background", .Background, .Epic, "AlienPlanet") },
        { Cosmetic("Minecraft Background", .Background, .Epic, "Minecraft") },
        { Cosmetic("Stargazing Background", .Background, .Epic, "Stargazing") },
        { Cosmetic("Ocean Cat Background", .Background, .Epic, "OceanCat") },
        { Cosmetic("Squiggle Flashcard", .FlashcardBackground, .Epic, "Squiggles") },
        { Cosmetic("Leaf Flashcard", .FlashcardBackground, .Epic, "Leaves") },
        { Cosmetic("Quotes Flashcard", .FlashcardBackground, .Epic, "Quotes") },
        { Cosmetic("Charcoal Flashcard", .FlashcardBackground, .Epic, "Charcoal") },
        { Cosmetic("Goku", .Avatar, .Epic, "Goku") },
        { Cosmetic("Jazz", .Avatar, .Epic, "Jazz") },
        { Cosmetic("Mike", .Avatar, .Epic, "Mike") },
        { Cosmetic("Shocked", .Avatar, .Epic, "Shocked") },
    ];
    public static var fiveStars: [() -> Cosmetic] = [
        { Cosmetic("Cityscape Background", .Background, .Legendary, "Cityscape") },
        { Cosmetic("Lofi Background", .Background, .Legendary, "Lofi") },
        { Cosmetic("Swirl Background", .Background, .Legendary, "Swirl") },
        { Cosmetic("Neon Flashcard", .FlashcardBackground, .Legendary, "Neon") },
        { Cosmetic("Gold Frame Flashcard", .FlashcardBackground, .Legendary, "GoldFrame") },
        { Cosmetic("Magic Elf", .Avatar, .Legendary, "MagicElf") },
        { Cosmetic("Mega Kermit", .Avatar, .Legendary, "MegaKermit") },
    ];
    
    // Cosmetic("Gojo", .Avatar, .Legendary, "Gojo")
    // Cosmetic("Miku", .Avatar, .Legendary, "Miku")
    
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
