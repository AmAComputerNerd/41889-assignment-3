//
//  RootView.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 9/5/2025.
//

import SwiftUI

struct RootView: View {
    // This view exists for the sole purpose of hosting the NavigationManager. It should never be navigated to normally.
    @StateObject private var navigationManager: NavigationManager = NavigationManager();
    
    var body: some View {
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

#Preview {
    RootView()
}
