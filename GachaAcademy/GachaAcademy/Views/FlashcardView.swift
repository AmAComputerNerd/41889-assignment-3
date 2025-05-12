//
//  FlashcardView.swift
//  GachaAcademy
//
//  Created by Kyan Grimm on 12/5/2025.
//

import Foundation
import SwiftUI

struct FlashcardView: View {
    @Environment(\.modelContext) private var modelContext;
    @StateObject var viewModel: FlashcardViewModel = FlashcardViewModel();
    @EnvironmentObject private var navigationManager: NavigationManager;
    
    var body: some View {
        GeometryReader { geometry in
            ZStack
            {
                BackgroundView(spriteName: viewModel.user?.backgroundSpriteName)
                Text("Flashcards")
                    .font(.title)
                    .foregroundStyle(.black)
                    .position(x:geometry.size.width/2, y:geometry.size.height * 0.1)
                Button(action: {
                    navigationManager.navigate(to: ProfileView.self);
                }) {
                    if let avatar = viewModel.user?.avatarSpriteName {
                        Image(avatar)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.secondary, lineWidth: 2))
                    } else {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 45, height: 45)
                    }
                }.position(CGPoint(x: geometry.size.width*0.9, y: geometry.size.height*0.1))
                VStack
                {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .overlay(content: {
                            if let card = viewModel.user?.flashcardBackgroundSpriteName {
                                Image(card)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.25)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            else
                            {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.brown)
                                    .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.25)
                                    .opacity(0.4)
                            }
                            Text("Front")
                        })
                        .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.25)
                        .position(CGPoint(x: geometry.size.width/2, y: geometry.size.height/2))
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
                }
            }
        }
        .onAppear {
            viewModel.refresh(modelContext: modelContext)
            viewModel.Flashcards.append(Flashcard(front: "front", back: "back"))
        }
    }
}

#Preview {
    FlashcardView()
        .environmentObject(NavigationManager())
        .modelContainer(for: [User.self, Cosmetic.self, FlashcardFolder.self, FlashcardSet.self, Flashcard.self])
}
