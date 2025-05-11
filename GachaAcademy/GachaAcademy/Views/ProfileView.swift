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
            
            if let avatar = viewModel.user?.avatarSpriteName {
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
            UpdateAPIKeyView(viewModel: viewModel)
        }
        .sheet(isPresented: $showingCosmeticsSelector) {
            CosmeticsSelectorView(viewModel: viewModel)
        }
        .sheet(isPresented: $showingImportFlashcard) {
            ImportFlashcardsView(viewModel: viewModel)
        }
        .onAppear() {
            viewModel.refresh(modelContext: modelContext)
        }
    }
}

struct UpdateAPIKeyView: View {
    @StateObject var viewModel: ProfileViewModel;
    @State private var newAPIKey: String = "";
    @Environment(\.dismiss) var dismiss;
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter New API Key")) {
                    TextField("API Key", text: $newAPIKey)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                Section {
                    Button("Test Connection") {
                        // TODO: Test API connection and update validation field.
                        viewModel.validationErrorMessage = "Failed to hit the API - is your key valid?"
                        viewModel.apiKeyIsValid = false;
                    }
                    if viewModel.validationErrorMessage != nil {
                        let success = viewModel.apiKeyIsValid
                        Text("\(viewModel.validationErrorMessage!)")
                            .foregroundStyle(success ? .green : .red)
                    }
                }
                
                Text("Don't have a Dolphin Flashcards account yet? See [here](https://docs.dolphinflashcards.com/api-reference/authentication) for instructions on how to set one up, paste it into the box above and start studying!")
            }
            .navigationTitle("Update API Key")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        viewModel.updateAPIKey(newAPIKey)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct CosmeticsSelectorView: View {
    @StateObject var viewModel: ProfileViewModel;
    @Environment(\.dismiss) var dismiss;
    @State private var selectedCosmetics: [CosmeticType: Cosmetic] = [:];
    
    var body: some View {
        NavigationView {
            TabView {
                ForEach(CosmeticType.allCases, id: \.self) { type in
                    let selectedBinding: Binding<Cosmetic?> = Binding(
                        get: { selectedCosmetics[type] ?? viewModel.user!.appliedCosmetics.first { $0.type == type } },
                        set: { selectedCosmetics[type] = $0 }
                    )
                    
                    CosmeticsCategoryView(
                        type: type,
                        availableCosmetics: viewModel.availableCosmetics.filter { $0.type == type },
                        selectedCosmetic: selectedBinding
                    )
                    .tabItem { Text(type.rawValue) }
                }
            }
            .navigationTitle("Select Cosmetics")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        viewModel.applyCosmetics(Array(selectedCosmetics.values));
                        dismiss();
                    }
                }
            }
        }
    }
}

struct CosmeticsCategoryView: View {
    var type: CosmeticType;
    var availableCosmetics: [Cosmetic];
    @Binding var selectedCosmetic: Cosmetic?
    
    var body: some View {
        List {
            ForEach(availableCosmetics) { cosmetic in
                HStack {
                    if cosmetic.spriteName != nil {
                        Image(cosmetic.spriteName!)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 50, height: 50)
                            .backgroundStyle(.gray)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(cosmetic.name)
                            .font(.headline)
                        Text("Rarity: \(cosmetic.rarity.rawValue)")
                            .font(.headline)
                    }
                    
                    Spacer()
                    
                    if selectedCosmetic?.id == cosmetic.id {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedCosmetic = selectedCosmetic?.id == cosmetic.id ? nil : cosmetic;
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(type.rawValue)
    }
}

struct ImportFlashcardsView: View {
    @StateObject var viewModel: ProfileViewModel;
    @State private var flashcardURL: String = "";
    @Environment(\.dismiss) var dismiss;
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Flashcard Set URL")) {
                    TextField("Enter URL", text: $flashcardURL)
                        .keyboardType(.URL)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                Section {
                    Button("Import") {
                        let result = viewModel.importFlashcardSet(from: flashcardURL);
                        if result {
                            dismiss()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    if viewModel.validationErrorMessage != nil {
                        Text("\(viewModel.validationErrorMessage!)")
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("Import Flashcards")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss();
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(NavigationManager())
        .modelContainer(for: [User.self, Cosmetic.self, FlashcardFolder.self, FlashcardSet.self, Flashcard.self])
}
