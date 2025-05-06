//
//  FourStarEnum.swift
//  GachaAcademy
//
//  Created by Kyan Grimm on 6/5/2025.
//

import Foundation

enum FourStars : Int, CaseIterable, CustomStringConvertible
{
    case Item1 = 1
    case Item2 = 2
    case Item3 = 3
    case Item4 = 4
    case Item5 = 5
    
    var description: String {
        switch self {
            case .Item1: return "Bronze Helmet"
            case .Item2: return "Wooden Sword"
            case .Item3: return "Basic Staff"
            case .Item4: return "Iron Dagger"
            case .Item5: return "Leather Armor"
        }
    }
}
