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
    
    init()
    {
        pityCount = UserDefaults.standard.integer(forKey: "Pity");
    }
    
    func singlePull() -> Cosmetic
    {
        let newCosmeticRarity = getItemRarity();
        let newCosmeticName = getItemName(rarity: newCosmeticRarity);
        let newCosmeticImage = getAssetFromName(name: newCosmeticName);
        return Cosmetic(itemName: newCosmeticName, itemRarity: newCosmeticRarity, itemImage: newCosmeticImage);
    }
    
    func getItemRarity() -> Rarity
    {
        let rarity : Rarity;
        let selection = Int.random(in: 1...1000);
        if selection <= 60 // 5 star rate of 0.6%
        {
            rarity = .Legendary;
        }
        else if selection > 60 && selection <= 111 // 4 star rate of 5.1%
        {
            rarity = .Epic;
        }
        else // 3 star by default
        {
            rarity = .Common;
        }
        pityCount += 1;
        return rarity;
    }
    
    func getItemName(rarity : Rarity) -> String
    {
        let itemName : String;
        switch rarity
        {
            case .Common:
                let selection = Int.random(in: 0...10) // 10 is example number of 3 star items we add
                // get the selected item from the common items enum
                itemName = "unluggy";
            case .Epic:
                let selection = Int.random(in: 0...5) // 5 is example number of 4 star items we add
                // get the selected item from the epic items enum
                itemName = "arlan :)";
            case .Legendary:
                let selection = Int.random(in: 0...3) // 3 is example number of 5 star items we add
                // get the selected item from the legendary items enum
                itemName = "Yanqing :(";
        }
        return itemName;
    }
    
    func getAssetFromName(name: String) -> UIImage
    {
        return UIImage(); // later problem
    }
}
