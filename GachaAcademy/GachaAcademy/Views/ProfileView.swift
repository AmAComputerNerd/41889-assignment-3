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
    
    var body: some View {
        ZStack {
            BackgroundView(spriteName: viewModel.user?.backgroundSpriteName)
            VStack(spacing: 20) {
                Text("My Profile")
                    .font(.largeTitle)
                    .padding()
                
                if let avatar = viewModel.user?.avatarSpriteName {
                    Image(avatar)
                        .resizable()
                        .scaledToFill()
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
                    Text("API Token: \(viewModel.user?.apiToken ?? "Not set")");
                    Button("Update API Token") {
                        showingUpdateAPIKey = true;
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor.secondarySystemBackground))
                        .opacity(0.5)
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
                        .opacity(0.5)
                )
                
                VStack {
                    Button("Update Flashcards") {
                        Task {
                            let result = await viewModel.updateFlashcards()
                            if (result) {
                                viewModel.validationMessage = "Flashcards Updated";
                                viewModel.apiKeyIsValid = true;
                            }
                            else {
                                viewModel.validationMessage = "Failed To Get Flashcards. Is your API token valid?";
                                viewModel.apiKeyIsValid = false;
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    if viewModel.validationMessage != nil {
                        let success = viewModel.apiKeyIsValid
                        Text("\(viewModel.validationMessage!)")
                            .foregroundStyle(success ? .green : .red)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false , vertical: true)
                    }
                    
                    Button("View Saved Flashcards") {
                        navigationManager.navigate(to: SetSelectionView.self);
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor.secondarySystemBackground))
                        .opacity(0.5)
                )
                
                Button(action: {
                    navigationManager.navigate(to: HomeView.self);
                })
                {
                    Image("Home")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Spacer()
            }
            .padding()
            .sheet(isPresented: $showingUpdateAPIKey) {
                UpdateAPIKeyView(viewModel: viewModel)
            }
            .sheet(isPresented: $showingCosmeticsSelector) {
                CosmeticsSelectorView(viewModel: viewModel)
            }
            .onAppear() {
                viewModel.refresh(modelContext: modelContext)
            }
        }
    }
}

struct UpdateAPIKeyView: View {
    @StateObject var viewModel: ProfileViewModel;
    @State private var newAPIToken: String = "";
    @Environment(\.dismiss) var dismiss;
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter New API Token")) {
                    TextField("API Token", text: $newAPIToken)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                Section {
                    Button("Test Connection") {
                        Task {
                            if (await HTTPRequestHelper.testJWT(jwt: newAPIToken)) {
                                viewModel.validationMessage = "Connection Successful";
                                viewModel.apiKeyIsValid = true;
                            }
                            else {
                                viewModel.validationMessage = "Failed To Connect. Is your token valid?";
                                viewModel.apiKeyIsValid = false;
                            }
                        }
                    }
                    if viewModel.validationMessage != nil {
                        let success = viewModel.apiKeyIsValid
                        Text("\(viewModel.validationMessage!)")
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
                        viewModel.updateAPIKey(newAPIToken)
                        dismiss()
                    }
                }
            }
        }
        .onAppear() {
            newAPIToken = viewModel.user?.apiToken ?? "";
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
                        availableCosmetics: viewModel.availableCosmetics
                                .filter { $0.type == type }
                                .sorted(by: { $0.rarity < $1.rarity }),
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
                        Text("Rarity: \(itemRarityText(rarity: cosmetic.rarity))")
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
    
    func itemRarityText(rarity: Rarity) -> String {
        switch rarity {
            case .Common:
                return "⭐⭐⭐";
            case .Epic:
                return "⭐⭐⭐⭐";
            case .Legendary:
                return "⭐⭐⭐⭐⭐";
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(NavigationManager())
        .modelContainer(for: [User.self, Cosmetic.self, FlashcardFolder.self, FlashcardSet.self, Flashcard.self])
}
