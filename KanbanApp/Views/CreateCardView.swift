import SwiftUI

struct CreateCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var auth: AuthViewModel
    @State private var title = ""
    @State private var descriptionText = ""
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Detalhes do Card")) {
                    TextField("Título", text: $title)
                    TextField("Descrição", text: $descriptionText)
                }
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                Button(action: {
                    saveCard()
                }) {
                    Text("Salvar")
                }
            }
            .navigationTitle("Novo Card")
            .navigationBarItems(leading: Button("Cancelar") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    func saveCard() {
        guard !title.isEmpty else {
            errorMessage = "Título é obrigatório"
            return
        }
        guard let userId = auth.userId else { return }
        NetworkManager.shared.createCard(title: title, description: descriptionText, userId: userId) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            } else {
                errorMessage = "Erro ao criar o card"
            }
        }
    }
}

struct CreateCardView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCardView().environmentObject(AuthViewModel())
    }
}
