//
//  RarityEnum.swift
//  GachaAcademy
//
//  Created by Kyan Grimm on 5/5/2025.
//

import Foundation

enum Rarity : String, Comparable
{
    case Common = "3STAR"
    case Epic = "4STAR"
    case Legendary = "5STAR"
    
    var rank: Int {
        switch self {
        case .Common: return 1;
        case .Epic: return 2;
        case .Legendary: return 3;
        }
    }
    
    static func < (lhs: Rarity, rhs: Rarity) -> Bool {
        return lhs.rank < rhs.rank;
    }
}
