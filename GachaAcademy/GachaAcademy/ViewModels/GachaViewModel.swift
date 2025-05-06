//
//  GachaViewModel.swift
//  GachaAcademy
//
//  Created by Kyan Grimm on 5/5/2025.
//

import Foundation
import SwiftUI

class GachaViewModel : ObservableObject
{
    @AppStorage("Pity") var pityCount : Int = 0;
    @AppStorage("5StarRate") var current5StarRate : Double = 0.006;
    @Published var lastPulledItems : [Cosmetic] = [];
    
    init()
    {
        pityCount = UserDefaults.standard.integer(forKey: "Pity");
        current5StarRate = UserDefaults.standard.double(forKey: "5StarRate");
    }
    
    func singlePull()
    {
        lastPulledItems = [];
        pullItem();
    }
    
    func tenPull()
    {
        lastPulledItems = [];
        for _ in 1...10 {
            pullItem();
        }
    }
    
    func pullItem()
    {
        let newCosmeticRarity = getItemRarity();
        let newCosmeticName = getItemName(rarity: newCosmeticRarity);
        let newCosmeticImage = getAssetFromName(name: newCosmeticName);
        incrementPityCountAndRate();
        lastPulledItems.append(Cosmetic(itemName: newCosmeticName, itemRarity: newCosmeticRarity, itemImage: newCosmeticImage));
    }
    
    func getItemRarity() -> Rarity
    {
        let rarity : Rarity;
        let selection = Double.random(in: 0.001...1);
        if selection <= 1 * current5StarRate // 5 star rate of 0.6%
        {
            rarity = .Legendary;
            pityCount = 0;
            current5StarRate = 0.006;
        }
        else if selection >= 0.949 && selection <= 1 // 4 star rate of 5.1%
        {
            rarity = .Epic;
        }
        else // 3 star by default
        {
            rarity = .Common;
        }
        return rarity;
    }
    
    func getItemName(rarity : Rarity) -> String
    {
        switch rarity
        {
            case .Common:
                let selection = Int.random(in: 1...ThreeStars.allCases.count)
                if let itemName = ThreeStars(rawValue: selection)
                {
                    return "3 Star - \(itemName)";
                }
            case .Epic:
                let selection = Int.random(in: 1...FourStars.allCases.count)
                if let itemName = FourStars(rawValue: selection)
                {
                    return "4 Star - \(itemName)";
                }
            case .Legendary:
                let selection = Int.random(in: 1...FiveStars.allCases.count)
                if let itemName = FiveStars(rawValue: selection)
                {
                    return "5 Star - \(itemName)";
                }
        }
        return "No item found";
    }
    
    func getAssetFromName(name: String) -> UIImage
    {
        return UIImage(); // later problem
    }
    
    func incrementPityCountAndRate()
    {
        pityCount += 1;
        if (pityCount > 74)
        {
            current5StarRate += (1.0 - current5StarRate) / (90.0 - Double(pityCount));
        }
    }
}
