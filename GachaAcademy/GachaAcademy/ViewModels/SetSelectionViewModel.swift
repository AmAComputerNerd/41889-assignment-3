import Foundation
import SwiftData

class SetSelectionViewModel: ObservableObject {
    @Published var user: User? = nil;
    private var dataHelper: DataHelper? = nil;
    
    func refresh(modelContext: ModelContext) {
        dataHelper = DataHelper(modelContext: modelContext);
        user = dataHelper?.fetchUser();
    }
}
