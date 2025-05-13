//
//  HomeView.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 5/5/2025.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var navigationManager: NavigationManager
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView(spriteName: viewModel.user?.backgroundSpriteName)
            
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("Home")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Logged in as \(viewModel.userName)")
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
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
