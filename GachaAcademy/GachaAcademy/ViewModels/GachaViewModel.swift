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
    // TODO: Add pulled cosmetics to the list of Cosmetics with DataHelper. These will be used as the player's "available" cosmetics which determines which ones they can apply.
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
        incrementPityCountAndRate();
        switch newCosmeticRarity {
            case .Common:
                lastPulledItems.append(CosmeticFactory.createRandomThreeStar());
                break;
            case .Epic:
                lastPulledItems.append(CosmeticFactory.createRandomFourStar());
                break;
            case .Legendary:
                lastPulledItems.append(CosmeticFactory.createRandomFiveStar());
                break;
        }
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
    
    func incrementPityCountAndRate()
    {
        pityCount += 1;
        if (pityCount > 74)
        {
            current5StarRate += (1.0 - current5StarRate) / (90.0 - Double(pityCount));
        }
    }
}
