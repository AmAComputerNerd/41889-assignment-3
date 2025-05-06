//
//  CommonItemsEnum.swift
//  GachaAcademy
//
//  Created by Kyan Grimm on 6/5/2025.
//

import Foundation

enum ThreeStars : Int, CaseIterable, CustomStringConvertible
{
    case Item1 = 1
    case Item2 = 2
    case Item3 = 3
    case Item4 = 4
    case Item5 = 5
    case Item6 = 6
    case Item7 = 7
    case Item8 = 8
    case Item9 = 9
    case Item10 = 10
    
    var description: String {
        switch self {
            case .Item1: return "Bronze Helmet"
            case .Item2: return "Wooden Sword"
            case .Item3: return "Basic Staff"
            case .Item4: return "Iron Dagger"
            case .Item5: return "Leather Armor"
            case .Item6: return "Wooden Shield"
            case .Item7: return "Bronze Shield"
            case .Item8: return "Iron Shield"
            case .Item9: return "Bronze Sword"
            case .Item10: return "Iron Sword"
        }
    }
}
