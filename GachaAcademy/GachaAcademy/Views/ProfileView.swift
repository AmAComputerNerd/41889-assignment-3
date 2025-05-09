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
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.gray)
                .frame(width: 150, height: 150)
            Text("\(viewModel.user?.name ?? "Loading data...")")
                .bold()
                .font(.title)
                .padding()
            Text("API Key: \(viewModel.user?.apiKey ?? "Not set")");
            Text("Available cosmetics: \(viewModel.availableCosmetics.count)")
        }
        .onAppear() {
            viewModel.refresh(modelContext: modelContext)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(NavigationManager())
        .modelContainer(for: [User.self, Cosmetic.self, FlashcardSet.self, Flashcard.self])
}
