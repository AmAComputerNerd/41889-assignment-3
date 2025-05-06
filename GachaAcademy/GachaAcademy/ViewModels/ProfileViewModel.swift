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
        // TODO: Data refresh for User and cosmetics. Do we need a cosmetics manager?
        // Open question: Where do we store the user and cosmetics?
        if let dataHelper = dataHelper {
            dataHelper.refreshContext(modelContext: modelContext);
        } else {
            self.dataHelper = DataHelper(modelContext: modelContext);
        }
        self.user = self.dataHelper?.fetchUser();
        self.availableCosmetics = self.dataHelper?.fetchAllCosmetics() ?? [];
    }
}
