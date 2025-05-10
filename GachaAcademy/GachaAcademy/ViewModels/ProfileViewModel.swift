//
//  ProfileViewModel.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 6/5/2025.
//

import Foundation
import SwiftData

class ProfileViewModel: ObservableObject {
    @Published var user: User? = nil;
    @Published var availableCosmetics: [Cosmetic] = [];
    private var dataHelper: DataHelper? = nil;
    
    func refresh(modelContext: ModelContext) {
        if let dataHelper = dataHelper {
            dataHelper.refreshContext(modelContext: modelContext);
        } else {
            self.dataHelper = DataHelper(modelContext: modelContext);
        }
        self.user = self.dataHelper!.fetchUser();
        self.availableCosmetics = self.dataHelper!.fetchAllCosmetics();
    }
    
    func updateAPIKey(_ newKey: String) {
        if let dataHelper = self.dataHelper {
            _ = dataHelper.updateUser(apiKey: newKey);
            self.user = dataHelper.fetchUser();
        }
    }
    
    func importFlashcardSet(from url: String) {
        // TODO: Import
    }
}
