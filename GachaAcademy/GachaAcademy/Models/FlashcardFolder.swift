import Foundation
import SwiftData

@Model
class FlashcardFolder: Identifiable {
    var id: UUID = UUID();
    var name: String;
    @Relationship var owner: User?
    @Relationship var subFolders: [FlashcardFolder]
    @Relationship var flashcardSets: [FlashcardSet]
    
    init(name: String? = nil, subFolders: [FlashcardFolder] = [], sets: [FlashcardSet] = []) {
        self.name = name ?? "My Flashcards";
        self.subFolders = subFolders;
        self.flashcardSets = sets;
    }
}

