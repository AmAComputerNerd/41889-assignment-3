//
//  Flashcard.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 6/5/2025.
//

import Foundation
import SwiftData

@Model
class Flashcard: Identifiable {
    var id: UUID = UUID();
    var front: String;
    var back: String;
    
    init(front: String, back: String) {
        self.front = front;
        self.back = back;
    }
}
