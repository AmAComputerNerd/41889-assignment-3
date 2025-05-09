public class FolderDTO {
    let name: String
    var flashcardID: String?
    var cards: [FlashcardInfoDTO] = []
    var subfolders: [FolderDTO] = []

    init(name: String) {
        self.name = name
    }
}
