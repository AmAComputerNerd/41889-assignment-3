//
//  GachaAcademyApp.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 5/5/2025.
//

import SwiftUI

@main
struct GachaAcademyApp: App {
    @StateObject var navigationManager: NavigationManager = NavigationManager();

    var body: some Scene {
        WindowGroup {
            // Pass all environment objects needed by child views in here:
            let view = navigationManager.currentView
                .environmentObject(navigationManager)
                .modelContainer(for: [User.self, Cosmetic.self, FlashcardSet.self, Flashcard.self])
            
            if navigationManager.supportsNavigation {
                NavigationStack() {
                    view
                }
            } else {
                view
            }
        }
    }
}
