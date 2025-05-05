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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
