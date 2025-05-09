class FolderDTO {
    let name: String
    var flashcardID: String?
    var flashcards: [FlashcardInfoDTO] = []
    var subfolders: [FolderDTO] = []

    init(name: String) {
        self.name = name
    }
}
