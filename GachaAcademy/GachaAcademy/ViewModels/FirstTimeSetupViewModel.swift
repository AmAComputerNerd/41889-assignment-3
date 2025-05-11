//
//  FirstTimeSetupViewModel.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 9/5/2025.
//

import Foundation
import SwiftData

class FirstTimeSetupViewModel: ObservableObject {
    @Published var username: String = "";
    @Published var apiKey: String = "";
    @Published var isSetupRequired: Bool = true;
    @Published var validationErrorMessage: String? = nil;
    private var dataHelper: DataHelper? = nil;
    
    func refresh(modelContext: ModelContext) {
        if let dataHelper = dataHelper {
            dataHelper.refreshContext(modelContext: modelContext);
        } else {
            self.dataHelper = DataHelper(modelContext: modelContext);
        }
        
        if (dataHelper?.fetchUser()) != nil {
            isSetupRequired = false;
            return;
        }
    }
    
    func setupNewUser() {
        let user = User(name: self.username, apiKey: self.apiKey);
        let result = self.dataHelper?.createUserIfNotExists(user: user);
        if result == true {
            self.isSetupRequired = false;
            return;
        }
        self.validationErrorMessage = "Failed to setup new user as one already exists! Please check code logic.";
    }
    
    func resetUser() {
        // DEBUG
        let resultUser = self.dataHelper?.clearUser();
        let resultCosmetics = self.dataHelper?.clearCosmetics();
        if resultUser == true && resultCosmetics == true {
            self.validationErrorMessage = "DEBUG > Cleared user and cosmetics successfully.";
        } else {
            self.validationErrorMessage = "DEBUG > Failed to clear user / cosmetics - didn't exist, random error or self.dataHelper wasn't populated."
        }
    }
}
