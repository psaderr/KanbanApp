import SwiftUI

struct KanbanListView: View {
    @State private var cards: [Card] = []
    @State private var showingCreateCard = false
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View {
        NavigationView {
            List(cards) { card in
                VStack(alignment: .leading) {
                    Text(card.title)
                        .font(.headline)
                    Text(card.status)
                        .font(.subheadline)
                }
            }
            .navigationTitle("Kanban")
            .navigationBarItems(trailing:
                Button(action: {
                    showingCreateCard.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
            .onAppear {
                fetchCards()
            }
            // Abre a tela de criação de card como uma sheet
            .sheet(isPresented: $showingCreateCard) {
                CreateCardView()
                    .environmentObject(auth)
            }
        }
    }
    
    func fetchCards() {
        NetworkManager.shared.fetchCards { fetchedCards in
            if let fetchedCards = fetchedCards {
                self.cards = fetchedCards
            }
        }
    }
}

struct KanbanListView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanListView().environmentObject(AuthViewModel())
    }
}
