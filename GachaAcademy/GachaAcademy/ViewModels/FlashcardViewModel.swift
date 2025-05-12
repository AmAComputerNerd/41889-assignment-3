//
//  FlashcardViewModel.swift
//  GachaAcademy
//
//  Created by Kyan Grimm on 12/5/2025.
//

import Foundation
import SwiftData

class FlashcardViewModel: ObservableObject {
    private var dataHelper: DataHelper? = nil;
    @Published var user : User? = nil;
    @Published var Flashcards: [Flashcard] = [];
    
    func refresh(modelContext: ModelContext) {
        if let dataHelper = dataHelper {
            dataHelper.refreshContext(modelContext: modelContext);
        } else {
            self.dataHelper = DataHelper(modelContext: modelContext);
        }
        self.user = self.dataHelper?.fetchUser();
    }
}
