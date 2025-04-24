import SwiftUI

struct CreateCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var auth: AuthViewModel   // Deve conter, pelo menos, userId e (opcionalmente) companyId
    
    // Campos de entrada para a nova atividade (card)
    @State private var title: String = ""
    @State private var descriptionText: String = ""
    @State private var urgency: String = "normal"      // Valores: "urgente", "normal", "rotina"
    @State private var subgroup: String = "Nenhum"       // Valores: "Nenhum", "financeira", "estrutura", "logica"
    @State private var errorMessage: String = ""
    
    // Opções para os pickers
    let urgencyOptions = ["urgente", "normal", "rotina"]
    let subgroupOptions = ["Nenhum", "financeira", "estrutura", "logica"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Detalhes da Atividade")) {
                    TextField("Título", text: $title)
                        .autocapitalization(.sentences)
                    
                    TextField("Descrição (opcional)", text: $descriptionText)
                        .autocapitalization(.sentences)
                    
                    Picker("Urgência", selection: $urgency) {
                        ForEach(urgencyOptions, id: \.self) { option in
                            Text(option.capitalized)
                        }
                    }
                    
                    Picker("Subgrupo", selection: $subgroup) {
                        ForEach(subgroupOptions, id: \.self) { option in
                            Text(option.capitalized)
                        }
                    }
                }
                
                if !errorMessage.isEmpty {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
                
                Section {
                    Button(action: {
                        saveCard()
                    }) {
                        Text("Salvar")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("Nova Atividade")
            .navigationBarItems(leading: Button("Cancelar") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    func saveCard() {
        // Valida o título
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "O título é obrigatório."
            return
        }
        // Verifica se o usuário está autenticado
        guard let userId = auth.userId else {
            errorMessage = "Usuário não autenticado."
            return
        }
        // Obtém a empresa associada ao usuário. Se não houver, utiliza "1" como padrão.
        let companyId = auth.companyId ?? "1"
        // Se "Nenhum" for selecionado para subgroup, envia string vazia
        let subgroupValue = subgroup == "Nenhum" ? "" : subgroup
        
        // Chama o método createCard no NetworkManager
        NetworkManager.shared.createCard(
            title: title,
            description: descriptionText.isEmpty ? nil : descriptionText,
            urgency: urgency,
            companyId: companyId,
            subgroup: subgroupValue,
            userId: userId
        ) { success in
            DispatchQueue.main.async {
                if success {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    errorMessage = "Erro ao criar o card."
                }
            }
        }
    }
}

struct CreateCardView_Previews: PreviewProvider {
    static var previews: some View {
        // Para fins de preview, cria um AuthViewModel com dados de exemplo
        let authVM = AuthViewModel()
        authVM.userId = "123"       // Exemplo de ID de usuário
        authVM.companyId = "2"      // Exemplo de ID de empresa
        return CreateCardView().environmentObject(authVM)
    }
}
