//
//  GachaView.swift
//  GachaAcademy
//
//  Created by Kyan Grimm on 5/5/2025.
//

import Foundation
import SwiftUI

struct GachaView : View {
    @StateObject var viewModel: GachaViewModel = GachaViewModel();
    
    var body: some View {
        GeometryReader { geometry in
            ZStack
            {
                Text("Gacha Time")
                    .font(.title)
                    .foregroundStyle(.black)
                    .position(x:geometry.size.width/2, y:geometry.size.height * 0.1)
                Text("Pity \(viewModel.pityCount) rate \(viewModel.current5StarRate)")
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
                }
                .position(x:geometry.size.width/2, y:geometry.size.height * 0.9)
            }
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
}
