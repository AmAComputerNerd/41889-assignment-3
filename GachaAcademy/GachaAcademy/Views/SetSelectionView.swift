import SwiftUI

struct SetSelectionView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var navigationManager: NavigationManager
    
    @StateObject var viewModel = SetSelectionViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if let rootFolder = viewModel.user?.flashcards {
                    FolderNavigationView(folder: rootFolder)
                } else {
                    Text("No Flashcards Found")
                        .foregroundColor(.gray)
                        .padding()
                }
                
                Button(action: {
                    navigationManager.navigate(to: HomeView.self);
                })
                {
                    Image("Home")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .navigationTitle("Select Flashcard Set")
        }
        .onAppear {
            viewModel.refresh(modelContext: modelContext);
        }
    }
}
