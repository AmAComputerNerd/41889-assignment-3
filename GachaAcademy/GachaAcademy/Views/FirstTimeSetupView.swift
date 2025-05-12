//
//  FirstTimeSetupView.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 9/5/2025.
//

import SwiftUI

struct FirstTimeSetupView: View {
    @Environment(\.modelContext) private var modelContext;
    @EnvironmentObject private var navigationManager: NavigationManager;
    @StateObject private var viewModel: FirstTimeSetupViewModel = FirstTimeSetupViewModel();
    
    var body: some View {
        VStack {
            Text("Welcome to Gacha Academy!")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            Spacer()
            
            if viewModel.validationErrorMessage != nil {
                Text("\(viewModel.validationErrorMessage!)")
                    .foregroundStyle(.red)
            }
            
            Text("Please enter your username and your Dolphin Flashcards API key below to continue:")
                .multilineTextAlignment(.center)
            TextField("Name", text: $viewModel.username)
                .multilineTextAlignment(.center)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
            TextField("JWT Token", text: $viewModel.apiKey)
                .multilineTextAlignment(.center)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
            Spacer()
            Text("Don't have a Dolphin Flashcards account yet? See [here](https://docs.dolphinflashcards.com/api-reference/authentication) for instructions on how to set one up, paste it into the box above and start studying!")
                .multilineTextAlignment(.center)
            HStack {
                Button("Continue") {
                    viewModel.setupNewUser();
                }
                .buttonStyle(.borderedProminent)
                Button("Reset (Temporary))") {
                    viewModel.resetUser();
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear() {
            viewModel.refresh(modelContext: modelContext)
        }
        .onChange(of: viewModel.isSetupRequired) {
            if !viewModel.isSetupRequired {
                navigationManager.navigate(to: HomeView.self, supportsNavigation: true);
            }
        }
        .padding()
    }
}

#Preview {
    FirstTimeSetupView()
        .environmentObject(NavigationManager())
        .modelContainer(for: [User.self, Cosmetic.self, FlashcardFolder.self, FlashcardSet.self, Flashcard.self])
}
