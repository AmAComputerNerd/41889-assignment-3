//
//  FlashcardViewModel.swift
//  GachaAcademy
//
//  Created by Tristan Huang on 13/5/2025.
//

import Foundation
import SwiftData

class FlashcardViewModel: ObservableObject {
    private var dataHelper: DataHelper? = nil;
    @Published var user : User? = nil;
    
    func refresh(modelContext: ModelContext) {
        if let dataHelper = dataHelper {
            dataHelper.refreshContext(modelContext: modelContext);
        } else {
            self.dataHelper = DataHelper(modelContext: modelContext);
        }
        self.user = self.dataHelper?.fetchUser();
    }
}
