//
//  ProfileViewModel.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 6/5/2025.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: User? = nil;
    @Published var availableCosmetics: [Cosmetic] = [];
    
    func refresh() async {
        // TODO: Data refresh for User and cosmetics. Do we need a cosmetics manager?
        // Open question: Where do we store the user and cosmetics?
        self.user = await retrieveUser();
        self.availableCosmetics = await retrieveCosmetics();
    }
    
    private func retrieveUser() async -> User? {
        // TODO: This
        return nil;
    }
    
    private func retrieveCosmetics() async -> [Cosmetic] {
        // TODO: This
        return [];
    }
    
    private func saveUser() async {
        // TODO: This
    }
}
