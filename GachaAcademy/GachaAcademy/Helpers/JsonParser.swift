import Foundation

class JsonParser {
    static func parseFolders(data: Data) throws -> [FolderDTO] {
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        return json?.compactMap { parseFolder(name: $0.key, content: $0.value as? [String: Any]) } ?? []
    }
    
    static func parseFolder(name: String, content: [String: Any]?) -> FolderDTO? {
        guard let content = content else { return nil }
        
        let folder = FolderDTO(name: name)
    
        if let flashcardID = content["flashcard_id"] as? String {
            folder.flashcardID = flashcardID
        }
    
        if let cardsDict = content["cards"] as? [String: [String: Any]] {
            folder.flashcards = cardsDict.compactMap { cardID, info in
                guard let lastReview = info["last_review"] as? String,
                      let reviewStatus = info["review_status"] as? String
                else {
                    return nil
                }
                
                return FlashcardInfoDTO(cardID: cardID, lastReview: lastReview, reviewStatus: reviewStatus)
            }
        }
    
        for (key, value) in content {
            if key != "cards", key != "flashcard_id",
               let subfolderContent = value as? [String: Any] {
                if let subfolder = parseFolder(name: key, content: subfolderContent) {
                    folder.subfolders.append(subfolder)
                }
            }
        }
    
        return folder
    }
}
