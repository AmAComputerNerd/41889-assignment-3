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
                RoundedRectangle(cornerRadius: 25)
                    .fill(.gray)
                    .opacity(0.2)
                    .frame(width: geometry.size.width*0.8, height: geometry.size.height*0.65)
                    .padding()
                HStack
                {
                    Button(action: {
                        // single pull
                    }) {
                        Text("1 Pull")
                            .frame(minWidth: geometry.size.width*0.2, minHeight: geometry.size.height*0.05)
                    }
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius:  5))
                    .padding()
                    
                    Button(action: {
                        // 10 pull
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
}

#Preview {
    GachaView()
}
