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
    var rarityData : String;
    var rarity : Rarity {
        Rarity(rawValue: rarityData)!;
    }
    var spriteData : Data;
    var sprite: UIImage? {
        UIImage(data: spriteData)
    }
    
    init(itemName : String, itemRarity : Rarity, itemImage : UIImage)
    {
        name = itemName;
        rarityData = itemRarity.rawValue;
        spriteData = itemImage.pngData() ?? Data();
    }
}
