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
            RootView()
        }
    }
}
