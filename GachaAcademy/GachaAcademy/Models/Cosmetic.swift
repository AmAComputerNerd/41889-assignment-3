//
//  Cosmetic.swift
//  GachaAcademy
//
//  Created by Kyan Grimm on 5/5/2025.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Cosmetic : Identifiable
{
    var id = UUID();
    var name : String;
    var typeData: String;
    var type : CosmeticType {
        CosmeticType(rawValue: typeData)!;
    }
    var rarityData : String;
    var rarity : Rarity {
        Rarity(rawValue: rarityData)!;
    }
    var spriteData : Data;
    var sprite: UIImage? {
        UIImage(data: spriteData)
    }
    
    init(_ name : String, _ type: CosmeticType, _ rarity : Rarity, _ image : UIImage?)
    {
        self.name = name;
        self.typeData = type.rawValue;
        self.rarityData = rarity.rawValue;
        self.spriteData = image?.pngData() ?? Data();
    }
}
