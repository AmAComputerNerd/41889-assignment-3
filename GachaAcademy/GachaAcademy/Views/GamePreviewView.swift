import SwiftUI

struct GamePreviewView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @ObservedObject var flashcardSet: FlashcardSet;
    
    var body: some View {
        Text(flashcardSet.name)
        
        Button(action: {
            navigationManager.navigate(to: QuizView.self, withParams: { AnyView(QuizView(flashcardSet: flashcardSet)) })
        }) {
            Text("Start Game")
        }
        .disabled(flashcardSet.flashcards.count < 4)
        .buttonStyle(.borderedProminent)
        
        if (flashcardSet.flashcards.count < 4) {
            Text("Flashcard set must have 4 or more flashcards to play quiz.")
                .foregroundColor(.red)
        }
    }
}
