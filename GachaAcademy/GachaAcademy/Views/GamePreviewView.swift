import SwiftUI

struct GamePreviewView: View {
    @ObservedObject var flashcardSet: FlashcardSet;
    
    var body: some View {
        Text(flashcardSet.name)
    }
}
