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
    // TODO: Add pulled cosmetics to the list of Cosmetics with DataHelper. These will be used as the player's "available" cosmetics which determines which ones they can apply.
    @AppStorage("Pity") var pityCount : Int = 0;
    @AppStorage("5StarRate") var current5StarRate : Double = 0.006;
    @AppStorage("5StarRate") var current4StarRate : Double = 0.051;
    @AppStorage("Last4Star") var last4Star : Int = 0;
    @Published var lastPulledItems : [Cosmetic] = [];
    private var dataHelper: DataHelper? = nil;
    @Published var user: User? = nil;
    
    func refresh(modelContext: ModelContext) {
        // TODO: Data refresh for User and cosmetics. Do we need a cosmetics manager?
        // Open question: Where do we store the user and cosmetics?
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
        last4Star = UserDefaults.standard.integer(forKey: "last4Star");
    }
    
    func singlePull()
    {
        if user!.ticketCount >= 1
        {
            lastPulledItems = [];
            pullItem();
        }
    }
    
    func tenPull()
    {
        if user!.ticketCount >= 10
        {
            lastPulledItems = [];
            for _ in 1...10 {
                pullItem();
            }
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
        _ = dataHelper?.updateUser(name: user?.name, apiKey: user?.apiKey, avatarURL: user?.avatarURL, ticketCount: user!.ticketCount - 1)
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
            last4Star = 0;
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
        if lastPulledItems.last?.rarity != .Epic
        {
            current4StarRate += ((1.0 - current5StarRate) / (90.0 - Double(pityCount)) / (10 - current4StarRate));
        }
        if (pityCount > 74) // exponentially increase 5 star rate when between 75 and 90 pity
        {
            current5StarRate += (1.0 - current5StarRate) / (90.0 - Double(pityCount));
        }
    }
    
    func giveTicket()
    {
        _ = dataHelper?.updateUser(name: user?.name, apiKey: user?.apiKey, avatarURL: user?.avatarURL, ticketCount: user!.ticketCount + 1)
    }
}
