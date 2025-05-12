import SwiftUI

struct SetSelectionView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel = SetSelectionViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                    .padding()
                    Spacer()
                }

                if let rootFolder = viewModel.user?.flashcards {
                    FolderNavigationView(folder: rootFolder)
                } else {
                    Text("No flashcards found.")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .navigationTitle("Select Flashcard Set")
        }
        .onAppear {
            viewModel.refresh(modelContext: modelContext)
        }
    }
}
