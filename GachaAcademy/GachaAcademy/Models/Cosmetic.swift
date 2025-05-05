//
//  Cosmetic.swift
//  GachaAcademy
//
//  Created by Kyan Grimm on 5/5/2025.
//

import Foundation
import SwiftUI

struct Cosmetic
{
    let name : String;
    let rarity : Rarity;
    let sprite : UIImage;
    
    init(itemName : String, itemRarity : Rarity, itemImage : UIImage)
    {
        name = itemName;
        rarity = itemRarity;
        sprite = itemImage;
    }
}
