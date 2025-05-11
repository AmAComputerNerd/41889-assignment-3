//
//  GachaView.swift
//  GachaAcademy
//
//  Created by Kyan Grimm on 5/5/2025.
//

import Foundation
import SwiftUI

struct GachaView : View {
    @Environment(\.modelContext) private var modelContext;
    @EnvironmentObject private var navigationManager: NavigationManager;
    @StateObject var viewModel: GachaViewModel = GachaViewModel();
    @State private var shouldFade: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            ZStack
            {
                Text("Cosmetics Gacha")
                    .font(.title)
                    .foregroundStyle(.black)
                    .position(x:geometry.size.width/2, y:geometry.size.height * 0.1)
                Text("Pity \(viewModel.pityCount) 5 rate \(viewModel.current5StarRate) 4 rate \(viewModel.current4StarRate) tickets \(String(describing: viewModel.user?.ticketCount))")
                    .position(x:geometry.size.width/2, y:geometry.size.height * 0.15)
                RoundedRectangle(cornerRadius: 25)
                    .overlay(content: {
                        if !viewModel.lastPulledItems.isEmpty
                        {
                            VStack(spacing: 5){
                                ForEach(viewModel.lastPulledItems) { item in
                                    ZStack
                                    {
                                        Rectangle()
                                            .fill(color(for: item.rarity))
                                            .opacity(shouldFade ? 1.0 : 0.0)
                                        
                                        HStack
                                        {
                                            Image(item.spriteName!).resizable()
                                                .scaledToFit()
                                                .frame(width: 40, height: 40)
                                                .clipped()
                                            Text(item.name)
                                                .foregroundColor(color(for: item.rarity))
                                                .font(.title3)
                                        }
                                    }
                                    .animation(.easeOut(duration: 1.0), value: shouldFade)
                                }
                            }
                        }
                    })
                    .foregroundColor(.gray
                    .opacity(0.2))
                    .frame(width: geometry.size.width*0.8, height: geometry.size.height*0.65)
                    .padding()
                VStack
                {
                    HStack
                    {
                        Button(action: {
                            viewModel.singlePull();
                        }) {
                            Text("1 Pull")
                                .frame(minWidth: geometry.size.width*0.2, minHeight: geometry.size.height*0.05)
                        }
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius:  5))
                        .padding()
                        
                        Button(action: {
                            viewModel.tenPull();
                        }) {
                            Text("10 Pulls")
                                .frame(minWidth: geometry.size.width*0.2, minHeight: geometry.size.height*0.05)
                        }
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius:  5))
                        .padding()
                        
                        Button(action: {
                            viewModel.giveTicket()
                        }) {
                            Text("Give Ticket")
                        }
                    }
                    .position(x:geometry.size.width/2, y:geometry.size.height * 0.9)
                    
                    if viewModel.currencyError
                    {
                        Text("You do not have enough tickets")
                            .foregroundStyle(.red)
                            .font(.caption)
                    }
                    
                    Button("Back to Home") {
                        navigationManager.navigate(to: HomeView.self);
                    }
                }
            }
        }
        .onAppear() {
            viewModel.refresh(modelContext: modelContext)
        }
        .onChange(of: viewModel.lastPulledItems) { oldValue, newValue in
            if oldValue != newValue {
                triggerFade()
            }
        }
    }
    
    func color(for rarity: Rarity) -> Color {
        switch rarity {
        case .Common:
            return .blue
        case .Epic:
            return .purple
        case .Legendary:
            return .yellow
        }
    }
    
    private func triggerFade() {
            shouldFade = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                shouldFade = false
            }
        }
}

#Preview {
    GachaView()
        .environmentObject(NavigationManager())
        .modelContainer(for: [User.self, Cosmetic.self, FlashcardFolder.self, FlashcardSet.self, Flashcard.self])
}
