//
//  DataHelper.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 6/5/2025.
//

import Foundation
import SwiftData

class DataHelper: ObservableObject {
    @Published var dataVersion: Int = 0; // Can be used to trigger Views to refresh if they rely on SwiftData models by binding to this property.
    private var modelContext: ModelContext;
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func refreshContext(modelContext: ModelContext) {
        self.modelContext = modelContext;
        self.dataVersion = 0;
    }
    
    func fetchUser() -> User? {
        let descriptor = FetchDescriptor<User>();
        if let result = try? self.modelContext.fetch(descriptor).first
        {
            // for le de bug
            return result;
        }
        else
        {
            return nil;
        }
    }
    
    func createUserIfNotExists(user: User) -> Bool {
        guard fetchUser() == nil else {
            // Can only be one user - it already exists.
            return false;
        }
        self.modelContext.insert(user);
        return self.saveChanges();
    }
    
    func updateUser(name: String? = nil, apiKey: String? = nil, ticketCount: Int? = nil, appliedCosmetics: [Cosmetic]? = nil) -> Bool {
        guard let existingUser = self.fetchUser() else { return false; }
        
        if let name = name { existingUser.name = name }
        if let apiKey = apiKey { existingUser.apiToken = apiKey }
        if let ticketCount = ticketCount { existingUser.ticketCount = ticketCount }
        if let appliedCosmetics = appliedCosmetics { existingUser.appliedCosmetics = appliedCosmetics }
        
        return self.saveChanges();
    }
    
    func clearUser() -> Bool {
        guard let existingUser = self.fetchUser() else { return false; }
        
        self.modelContext.delete(existingUser);
        return self.saveChanges();
    }
    
    func updateFlashcards() async -> Bool {
        guard let existingUser = self.fetchUser() else { return false; }
        
        do {
            existingUser.flashcards = try await FlashcardManager.getAllFlashcards(jwt: existingUser.apiToken);
        }
        catch {
            return false;
        }
        return self.saveChanges();
    }
    
    func fetchAllCosmetics(predicate: Predicate<Cosmetic> = .true, sortDescriptors: [SortDescriptor<Cosmetic>] = []) -> [Cosmetic] {
        do {
            let descriptor = FetchDescriptor<Cosmetic>(predicate: predicate, sortBy: sortDescriptors);
            return try self.modelContext.fetch(descriptor);
        } catch {
            return [];
        }
    }
    
    func addCosmetic(cosmetic: Cosmetic) -> Bool {
        let nameToMatch = cosmetic.name;
        let namePredicate = #Predicate<Cosmetic> { existingCosmetic in
            existingCosmetic.name == nameToMatch
        }
        
        let duplicateCosmetics = fetchAllCosmetics(predicate: namePredicate);
        
        guard !duplicateCosmetics.isEmpty else
        {
            self.modelContext.insert(cosmetic);
            return self.saveChanges();
        }
        return false;
    }
    
    func removeCosmetic(cosmetic: Cosmetic) -> Bool {
        self.modelContext.delete(cosmetic);
        return self.saveChanges();
    }
    
    func clearCosmetics() -> Bool {
        try? self.modelContext.delete(model: Cosmetic.self);
        return self.saveChanges();
    }
    
    @discardableResult
    private func saveChanges() -> Bool {
        do {
            try self.modelContext.save();
        } catch {
            return false;
        }
        
        self.dataVersion += 1;
        return true;
    }
}
