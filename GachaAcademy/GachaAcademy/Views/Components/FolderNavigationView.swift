import SwiftUI

struct FolderNavigationView: View {
    let folder: FlashcardFolder

    var body: some View {
        List {
            Section(header: Text("Folders")) {
                ForEach(folder.subFolders) { subfolder in
                    NavigationLink(destination: FolderNavigationView(folder: subfolder)) {
                        Label(subfolder.name, systemImage: "folder")
                    }
                }
            }

            Section(header: Text("Flashcard Sets")) {
                ForEach(folder.flashcardSets) { set in
                    NavigationLink(destination: QuizPreviewView(flashcardSet: set)) {
                        Label(set.name, systemImage: "document.on.document")
                    }
                }
            }
        }
        .navigationTitle(folder.name)
    }
}

