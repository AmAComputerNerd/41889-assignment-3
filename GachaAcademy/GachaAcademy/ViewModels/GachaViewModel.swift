//
//  GachaViewModel.swift
//  GachaAcademy
//
//  Created by Kyan Grimm on 5/5/2025.
//

import Foundation
import SwiftUI
import SwiftData

class GachaViewModel : ObservableObject
{
    @AppStorage("Pity") var pityCount : Int = 0;
    @AppStorage("5StarRate") var current5StarRate : Double = 0.006;
    @AppStorage("4StarRate") var current4StarRate : Double = 0.051;
    @AppStorage("isGuaranteed") var isGuaranteed : Bool = false;
    @Published var lastPulledItems : [Cosmetic] = [];
    private var dataHelper: DataHelper? = nil;
    @Published var user: User? = nil;
    @Published var currencyError = false;
    @Published var targetBanner = "Gojo";
    
    func refresh(modelContext: ModelContext) {
        if let dataHelper = dataHelper {
            dataHelper.refreshContext(modelContext: modelContext);
        } else {
            self.dataHelper = DataHelper(modelContext: modelContext);
        }
        self.user = self.dataHelper?.fetchUser();
    }
    
    init()
    {
        pityCount = UserDefaults.standard.integer(forKey: "Pity");
        current5StarRate = UserDefaults.standard.double(forKey: "5StarRate");
        current4StarRate = UserDefaults.standard.double(forKey: "4StarRate");
        isGuaranteed = UserDefaults.standard.bool(forKey: "isGuaranteed");
    }
    
    func singlePull()
    {
        guard user == nil else
        {
            if user!.ticketCount >= 1
            {
                lastPulledItems = [];
                pullItem();
            }
            else
            {
                currencyError = true;
            }
            return;
        }
    }
    
    func tenPull()
    {
        guard user == nil else
        {
            if user!.ticketCount >= 10
            {
                lastPulledItems = [];
                for _ in 1...10 {
                    pullItem();
                }
            }
            else
            {
                currencyError = true;
            }
            return;
        }
    }
    
    func pullItem()
    {
        currencyError = false;
        let newCosmeticRarity = getItemRarity();
        switch newCosmeticRarity {
            case .Common:
                lastPulledItems.append(CosmeticFactory.createRandomThreeStar());
                break;
            case .Epic:
                lastPulledItems.append(CosmeticFactory.createRandomFourStar());
                break;
            case .Legendary:
            if targetBanner == "Standard"
            {
                lastPulledItems.append(CosmeticFactory.createRandomFiveStar());
            }
            else
            {
                lastPulledItems.append(generateFiveStar());
            }
            break;
        }
        incrementPityCountAndRate();
        _ = dataHelper?.addCosmetic(cosmetic: lastPulledItems.last!);
        _ = dataHelper?.updateUser(ticketCount: user!.ticketCount - 1)
    }
    
    func getItemRarity() -> Rarity
    {
        let rarity : Rarity;
        let selection = Double.random(in: 0.001...1);
        if selection <= 1 * current5StarRate // 5 star rate of 0.6% multiplied by pity rate
        {
            rarity = .Legendary;
            pityCount = 0;
            current5StarRate = 0.006;
        }
        else if selection >= (1 - current4StarRate) && selection <= 1 // 4 star rate of 5.1%
        {
            rarity = .Epic;
            current4StarRate = 0.051;
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
        if lastPulledItems.last?.rarity != .Epic // increase 4 star rate for roughly one every 10 pulls
        {
            let mod = pityCount % 10;
            let target = 1 - current4StarRate; //0.949
            let unadjustedRateAddition = target / (10.0 - Double(mod)); //0.0949
            current4StarRate += unadjustedRateAddition / 10;
        }
        if (pityCount > 74) // exponentially increase 5 star rate when between 75 and 90 pity
        {
            current5StarRate += (1.0 - current5StarRate) / (90.0 - Double(pityCount));
        }
    }

    func generateFiveStar() -> Cosmetic
    {
        if !isGuaranteed
        {
            let wonFiftyFifty = Bool.random();
            if wonFiftyFifty
            {
                isGuaranteed = false;
                return Cosmetic(targetBanner, .Avatar, .Legendary, targetBanner);
            }
            else
            {
                isGuaranteed = true;
                return CosmeticFactory.createRandomFiveStar();
            }
        }
        isGuaranteed = false;
        return Cosmetic(targetBanner, .Avatar, .Legendary, targetBanner);
    }
    
    func getIsGuaranteed() -> Bool
    {
        return isGuaranteed;
    }
}
