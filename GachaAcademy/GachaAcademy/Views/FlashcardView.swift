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
    @State var showBack: Bool = false;
    @State var canFlip: Bool;
    @Binding var flashcard: Flashcard;
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .overlay(content: {
                    if let card = viewModel.user?.flashcardBackgroundSpriteName {
                        ZStack {
                            ZStack {
                                Image(card)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.25)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                Text(flashcard.front)
                            }
                            .opacity(showBack ? 0 : 1)
                            .rotation3DEffect(Angle.degrees(showBack ? 180 : 360), axis: (0,1,0))
                            ZStack {
                                Image(card)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.25)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .scaleEffect(x: -1)
                                Text(flashcard.back)
                            }
                            .opacity( showBack ? 1 : 0)
                            .rotation3DEffect(Angle.degrees(showBack ? 180 : 360), axis: (0,1,0))
                        }
                        .onTapGesture {
                            withAnimation {
                                if (canFlip) {
                                    self.showBack.toggle()
                                }
                            }
                        }
                    }
                    else
                    {
                        ZStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.brown)
                                    .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.25)
                                    .opacity(0.4)
                                Text(flashcard.front)
                            }
                            .opacity(showBack ? 0 : 1)
                            .rotation3DEffect(Angle.degrees(showBack ? 180 : 360), axis: (0,1,0))
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.brown)
                                    .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.25)
                                    .opacity(0.4)
                                Text(flashcard.back)
                                    .scaleEffect(x: -1)
                            }
                            .opacity(showBack ? 1 : 0)
                            .rotation3DEffect(Angle.degrees(showBack ? 180 : 360), axis: (0,1,0))
                        }
                        .onTapGesture {
                            withAnimation {
                                if (canFlip) {
                                    self.showBack.toggle()
                                }
                            }
                        }
                    }
                })
                .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.25)
                .position(CGPoint(x: geometry.size.width/2, y: geometry.size.height/2))
        }
        .onAppear {
            viewModel.refresh(modelContext: modelContext)
        }
    }
}
