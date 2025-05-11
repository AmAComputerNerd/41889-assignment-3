//
//  CosmeticFactory.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 7/5/2025.
//

import Foundation

class CosmeticFactory {
    public static var threeStars: [() -> Cosmetic] = [
        { Cosmetic("Bronze Avatar", .Avatar, .Common, "example_avatar") },
        { Cosmetic("Wooden Background", .Background, .Common, "example_background") },
        { Cosmetic("Basic Flashcard Background", .FlashcardBackground, .Common, nil) },
        { Cosmetic("Iron Flashcard Border", .FlashcardBorder, .Common, nil) },
        //{ Cosmetic("Leather Armour", .Dummy, .Common, nil) },
        //{ Cosmetic("Wooden Shield", .Dummy, .Common, nil) },
        //{ Cosmetic("Bronze Shield", .Dummy, .Common, nil) },
        //{ Cosmetic("Iron Shield", .Dummy, .Common, nil) },
        //{ Cosmetic("Bronze Sword", .Dummy, .Common, nil) },
        //{ Cosmetic("Iron Sword", .Dummy, .Common, nil) },
    ];
    public static var fourStars: [() -> Cosmetic] = [
        { Cosmetic("Bronze Helmet", .Dummy, .Epic, nil) },
        { Cosmetic("Wooden Sword", .Dummy, .Epic, nil) },
        { Cosmetic("Basic Staff", .Dummy, .Epic, nil) },
        { Cosmetic("Iron Dagger", .Dummy, .Epic, nil) },
        { Cosmetic("Leather Armour", .Dummy, .Epic, nil) },
    ];
    public static var fiveStars: [() -> Cosmetic] = [
        { Cosmetic("Bronze Helmet", .Dummy, .Legendary, nil) },
        { Cosmetic("Wooden Sword", .Dummy, .Legendary, nil) },
        { Cosmetic("Basic Staff", .Dummy, .Legendary, nil) },
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
