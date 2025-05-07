public class FolderDTO {
    let name: String
    var flashcardID: String?
    var cards: [CardInfo] = []
    var subfolders: [Folder] = []

    init(name: String) {
        self.name = name
    }
}
