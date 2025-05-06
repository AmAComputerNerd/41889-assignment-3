//
//  GachaAcademyApp.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 5/5/2025.
//

import SwiftUI

@main
struct GachaAcademyApp: App {
    let navigationManager = NavigationManager();

    var body: some Scene {
        WindowGroup {
            // Pass all environment objects needed by child views in here:
            let view = navigationManager.currentView
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
