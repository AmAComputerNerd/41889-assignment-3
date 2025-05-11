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
    
    var body: some View {
        GeometryReader { geometry in
            ZStack
            {
                Text("Gacha Time")
                    .font(.title)
                    .foregroundStyle(.black)
                    .position(x:geometry.size.width/2, y:geometry.size.height * 0.1)
                Text("Pity \(viewModel.pityCount) 5 rate \(viewModel.current5StarRate) 4 rate \(viewModel.current4StarRate) tickets")
                    .position(x:geometry.size.width/2, y:geometry.size.height * 0.15)
                RoundedRectangle(cornerRadius: 25)
                    .overlay(content: {
                        if !viewModel.lastPulledItems.isEmpty
                        {
                            VStack(spacing: 5){
                                ForEach(viewModel.lastPulledItems) { item in
                                    Text(item.name)
                                        .foregroundColor(color(for: item.rarity))
                                        .font(.title3)
                                }
                            }
                        }
                    })
                    .foregroundColor(.gray
                    .opacity(0.2))
                    .frame(width: geometry.size.width*0.8, height: geometry.size.height*0.65)
                    .padding()
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
                        Task {
                            do {
                                _ = try await FlashcardManager.retrieveAllFlashcardInfo(jwt: "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiIsImtpZCI6ImEzMmZkZDRiMTQ2Njc3NzE5YWIyMzcyODYxYmRlZDg5In0.eyJpc3MiOiJodHRwOi8vZG9scGhpbmZsYXNoY2FyZHMuY29tIiwiYXVkIjoiYXBpIiwic3ViIjoiVmRVNE5pdG5RS1RUaVRQM3FZSXNydlVrVG1VMiIsImFjY2Vzc190b2tlbiI6IjRiZTA2NDNmLTFkOTgtNTczYi05N2NkLWNhOThhNjUzNDdkZCIsImFjY2Vzc190b2tlbl9yYXciOiJ0ZXN0IiwiaWF0IjoxNzQ2MzgyMTc5fQ.TwBdfETmWrEkMukJ3AXcuQa4bDp8i2efLsyiYGczGkY80KitTeFk5DSzYnlvmNwtXZjJoCrHNzFrEVid4TdGqA");
                            }
                            catch {
                                //do nothin
                            }
                        }
                        }) {
                            Text("Test")
                        }
                    Button(action: {
                        viewModel.giveTicket()
                    }) {
                        Text("Give Ticket")
                    }
                    Button("Back to Home") {
                        navigationManager.navigate(to: HomeView.self);
                    }
                }
                .position(x:geometry.size.width/2, y:geometry.size.height * 0.9)
            }
        }
        .onAppear() {
            viewModel.refresh(modelContext: modelContext)
        }
    }
    
    func color(for rarity: Rarity) -> Color {
        switch rarity {
        case .Common:
            return .gray
        case .Epic:
            return .purple
        case .Legendary:
            return .yellow
        }
    }
}

#Preview {
    GachaView()
        .environmentObject(NavigationManager())
        .modelContainer(for: [User.self, Cosmetic.self, FlashcardFolder.self, FlashcardSet.self, Flashcard.self])
}
