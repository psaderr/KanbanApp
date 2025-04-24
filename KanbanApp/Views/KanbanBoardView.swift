import SwiftUI

struct KanbanBoardView: View {
    @State private var cards: [Card] = []
    
    // Defina os 4 status do quadro Kanban, conforme seu backend
    let statuses = ["nova", "pendente", "execucao", "finalizada"]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fundo gradiente igual ao LoginView
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "7B38D8"), Color(hex: "5186F7")]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(statuses, id: \.self) { status in
                            VStack {
                                Text(titleForStatus(status))
                                    .font(.headline)
                                    .padding()
                                ScrollView {
                                    ForEach(cards.filter { $0.status == status }) { card in
                                        CardView(card: card)
                                            .padding(.vertical, 4)
                                    }
                                }
                            }
                            .frame(width: 300)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .shadow(radius: 4)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Quadro Kanban")
            .navigationBarItems(trailing: Button(action: {
                // Ação para abrir a tela de criação de card pode ser adicionada aqui.
            }, label: {
                Image(systemName: "plus")
            }))
            .onAppear {
                fetchCards()
            }
        }
    }
    
    func titleForStatus(_ status: String) -> String {
        switch status {
        case "nova":
            return "Nova Atividade"
        case "pendente":
            return "Atividade Pendente"
        case "execucao":
            return "Atividade em Execução"
        case "finalizada":
            return "Atividade Finalizada"
        default:
            return status.capitalized
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

struct KanbanBoardView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanBoardView()
    }
}
