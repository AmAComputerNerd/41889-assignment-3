//
//  HomeView.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 5/5/2025.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext;
    @EnvironmentObject private var navigationManager: NavigationManager;
    @StateObject private var viewModel: HomeViewModel = HomeViewModel();
    
    var body: some View {
        VStack {
            Text("You have navigated to the Home screen, which means you're logged in!")
                .multilineTextAlignment(.center)
            Text("You are logged in as \(viewModel.userName)")
                .multilineTextAlignment(.center)
            Text("Your registered API key is: \(viewModel.apiKey)")
                .multilineTextAlignment(.center)
            Text("This page is all temporary for now and will be updated with cool UI in the future, for now though can use the buttons below to navigate to different pages, or reset the user and go back to the First Time Setup if you are testing that.")
                .multilineTextAlignment(.center)
                .padding()
            HStack {
                Button("Gacha") {
                    navigationManager.navigate(to: GachaView.self)
                }
                .buttonStyle(.borderedProminent)
                StyledNavigationLink(destination: ProfileView(), label: "Profile")
                Button("Reset User") {
                    viewModel.resetUser();
                    navigationManager.navigate(to: FirstTimeSetupView.self)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear() {
            viewModel.refresh(modelContext: modelContext)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(NavigationManager())
        .modelContainer(for: [User.self, Cosmetic.self, FlashcardSet.self, Flashcard.self])
}
