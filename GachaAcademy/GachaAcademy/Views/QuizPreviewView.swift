import SwiftUI

struct QuizPreviewView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @ObservedObject var flashcardSet: FlashcardSet;
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(flashcardSet.name)
                    .font(.title)
                
                ScrollView() {
                    VStack {
                        ForEach(flashcardSet.flashcards.indices, id: \.self) { index in
                            FlashcardView(
                                canFlip: true,
                                flashcard: Binding(
                                    get: { flashcardSet.flashcards[index] },
                                    set: { flashcardSet.flashcards[index] = $0 }
                                )
                            )
                            .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.25)
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.8)
                
                Button(action: {
                    navigationManager.navigate(to: QuizView.self, withParams: { AnyView(QuizView(flashcardSet: flashcardSet)) })
                }) {
                    Text("Start Quiz")
                }
                .disabled(flashcardSet.flashcards.count < 4)
                .buttonStyle(.borderedProminent)
                
                if (flashcardSet.flashcards.count < 4) {
                    Text("Flashcard set must have 4 or more flashcards to play quiz.")
                        .foregroundColor(.red)
                }
            }
        }
    }
}
