//
//  HomeView.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 5/5/2025.
//

import SwiftUI

// A custom view to style navigation buttons with a system image icon and title.
struct NavigationButtonLabel: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
            Text(title)
                .fontWeight(.medium)
                .font(.title3)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var navigationManager: NavigationManager
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            // The background fills the entire screen.
            BackgroundView(spriteName: viewModel.user?.backgroundSpriteName)
            
            VStack(spacing: 30) {
                // Header Section
                VStack(spacing: 10) {
                    Text("Home")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Logged in as \(viewModel.userName)")
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                // Navigation Buttons Section
                VStack(spacing: 20) {
                    Button(action: {
                        navigationManager.navigate(to: SetSelectionView.self)
                    }) {
                        ZStack {
                            Image("home-studyImg")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .overlay(
                                    Color.black.opacity(0.4)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                            Text("Study")
                                .font(.title)
                                .foregroundStyle(.white)
                                .bold()
                        }
                    }
                    
                    HStack(spacing: 10) {
                        Button(action: {
                            navigationManager.navigate(to: GachaView.self);
                        }) {
                            ZStack {
                                Image("home-gachaImg")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                                    .overlay(
                                        Color.black.opacity(0.4)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 50))
                                Text("Gacha")
                                    .font(.title)
                                    .foregroundStyle(.white)
                                    .bold()
                            }
                        }
                        Button(action: {
                            navigationManager.navigate(to: ProfileView.self)
                        }) {
                            ZStack {
                                Image("home-profileImg")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                                    .overlay(
                                        Color.black.opacity(0.4)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 50))
                                Text("Profile")
                                    .font(.title)
                                    .foregroundStyle(.white)
                                    .bold()
                            }
                        }
                    }
                    
                    Button(action: {
                        viewModel.resetUser()
                        navigationManager.navigate(to: FirstTimeSetupView.self)
                    }) {
                        NavigationButtonLabel(icon: "exclamationmark.triangle.fill", title: "Reset User (Temporary)")
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 30)
                .background(Color.black.opacity(0.1))
                .cornerRadius(15)
                
                Spacer()
            }
        }
        .onAppear {
            viewModel.refresh(modelContext: modelContext)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(NavigationManager())
        .modelContainer(for: [User.self, Cosmetic.self, FlashcardFolder.self, FlashcardSet.self, Flashcard.self])
}
