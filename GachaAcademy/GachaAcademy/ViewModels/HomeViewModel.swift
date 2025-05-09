//
//  HomeViewModel.swift
//  GachaAcademy
//
//  Created by Jonathon Thomson on 9/5/2025.
//

import Foundation
import SwiftData

class HomeViewModel: ObservableObject {
    @Published var userName: String = "";
    @Published var apiKey: String = "";
    @Published var gachaCount: Int = 0;
    private var dataHelper: DataHelper? = nil;
    
    func refresh(modelContext: ModelContext) {
        if let dataHelper = dataHelper {
            dataHelper.refreshContext(modelContext: modelContext);
        } else {
            self.dataHelper = DataHelper(modelContext: modelContext);
        }
        
        let user = dataHelper!.fetchUser();
        self.userName = user?.name ?? "Not logged in";
        self.apiKey = user?.apiKey ?? "";
    }
    
    func resetUser() {
        _ = self.dataHelper?.clearUser();
    }
}
