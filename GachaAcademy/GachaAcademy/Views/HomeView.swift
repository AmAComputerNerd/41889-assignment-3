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
        GeometryReader { geometry in
            ZStack {
                BackgroundView(spriteName: viewModel.user?.backgroundSpriteName)
                    Text("Home")
                        .font(.largeTitle)
                        .padding()
                        .position(x:geometry.size.width/2, y:geometry.size.height * 0.1)
                    Text("You are logged in as \(viewModel.userName)")
                        .multilineTextAlignment(.center)
                        .position(x:geometry.size.width/2, y:geometry.size.height * 0.2)
                    Text("Your registered API key is: \(viewModel.apiKey)")
                        .multilineTextAlignment(.center)
                        .position(x:geometry.size.width/2, y:geometry.size.height * 0.3)
                    VStack(spacing: 45, content: {
                        Button("Gacha") {
                            navigationManager.navigate(to: GachaView.self)
                        }
                        .buttonStyle(.borderedProminent)
                        Button("Profile") {
                            navigationManager.navigate(to: ProfileView.self)
                        }
                        .buttonStyle(.borderedProminent)
                        Button("Flashcards") {
                            navigationManager.navigate(to: FlashcardView.self)
                        }
                        .buttonStyle(.borderedProminent)
                        Button("Reset User") {
                            viewModel.resetUser();
                            navigationManager.navigate(to: FirstTimeSetupView.self)
                        }
                        .buttonStyle(.borderedProminent)
                    })
                    .position(x:geometry.size.width/2, y:geometry.size.height * 0.6)
                }
                .onAppear() {
                    viewModel.refresh(modelContext: modelContext)
                }
            }
        }
}

#Preview {
    HomeView()
        .environmentObject(NavigationManager())
        .modelContainer(for: [User.self, Cosmetic.self, FlashcardFolder.self, FlashcardSet.self, Flashcard.self])
}
