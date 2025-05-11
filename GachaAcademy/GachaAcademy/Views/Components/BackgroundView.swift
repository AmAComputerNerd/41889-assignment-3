//
//  BackgroundView.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 11/5/2025.
//

import SwiftUI

struct BackgroundView: View {
    var spriteName: String?;
    
    var body: some View {
        GeometryReader { geometry in
            if spriteName != nil {
                Image(spriteName!)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: geometry.size.width, maxHeight: .infinity)
                    .ignoresSafeArea(edges: .all)
                    .opacity(0.3)
                    .animation(.easeInOut(duration: 0.3), value: spriteName!)
            }
        }
    }
}

#Preview {
    BackgroundView(spriteName: nil)
}
