//
//  ProfileView.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 6/5/2025.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.modelContext) private var modelContext;
    @EnvironmentObject private var navigationManager: NavigationManager;
    @StateObject var viewModel: ProfileViewModel = ProfileViewModel();
    
    @State private var showingUpdateAPIKey = false;
    @State private var showingCosmeticsSelector = false;
    @State private var showingImportFlashcard = false;
    
    var body: some View {
        VStack(spacing: 20) {
            Text("My Profile")
                .font(.largeTitle)
                .padding()
            
            if let avatar = viewModel.user?.avatarURL {
                Image(avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.secondary, lineWidth: 2))
            } else {
                // Preview or no data
                Circle()
                    .fill(Color.gray)
                    .frame(width: 150, height: 150)
            }
            
            Text("\(viewModel.user?.name ?? "Loading data...")")
                .bold()
                .font(.title)
            
            VStack(spacing: 10) {
                Text("API Key: \(viewModel.user?.apiKey ?? "Not set")");
                Button("Update API Key") {
                    showingUpdateAPIKey = true;
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.secondarySystemBackground))
            )
            
            VStack {
                Text("Available cosmetics: \(viewModel.availableCosmetics.count)")
                Button("Select Cosmetics") {
                    showingCosmeticsSelector = true;
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.secondarySystemBackground))
            )
            
            Button("Import Flashcard Set") {
                showingImportFlashcard = true;
            }
            .buttonStyle(.bordered)
            
            Button("View Saved Flashcards") {
                // Temp - update to navigate to Flashcards view later.
                navigationManager.navigate(to: GachaView.self);
            }
            .buttonStyle(.bordered)
            
            Button("Back to Home") {
                navigationManager.navigate(to: HomeView.self);
            }
            .buttonStyle(.borderless)
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showingUpdateAPIKey) {
            // Smth
        }
        .sheet(isPresented: $showingCosmeticsSelector) {
            // Smth
        }
        .sheet(isPresented: $showingImportFlashcard) {
            // Smth
        }
        .onAppear() {
            viewModel.refresh(modelContext: modelContext)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(NavigationManager())
        .modelContainer(for: [User.self, Cosmetic.self, FlashcardFolder.self, FlashcardSet.self, Flashcard.self])
}
