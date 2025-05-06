//
//  GachaAcademyApp.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 5/5/2025.
//

import SwiftUI

@main
struct GachaAcademyApp: App {
    let persistenceController = PersistenceController.shared
    let navigationManager = NavigationManager();

    var body: some Scene {
        WindowGroup {
            // Pass all environment objects needed by child views in here:
            let view = navigationManager.currentView
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(navigationManager)
            
            if navigationManager.supportsNavigation {
                NavigationView() {
                    view
                }
            } else {
                view
            }
        }
    }
}
