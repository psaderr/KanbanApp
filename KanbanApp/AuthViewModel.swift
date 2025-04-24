import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var userId: String? = nil
    @Published var companyId: String? = nil  // Nova propriedade para armazenar o ID da empresa
    
    func login(email: String, password: String) {
        NetworkManager.shared.login(email: email, password: password) { success, userId in
            DispatchQueue.main.async {
                if success, let uid = userId {
                    self.userId = uid
                    self.isAuthenticated = true
                    // Se o endpoint de login retornar também o companyId,
                    // você pode atribuí-lo aqui. Exemplo:
                    // self.companyId = <valor retornado>
                } else {
                    self.isAuthenticated = false
                }
            }
        }
    }
    
    func logout() {
        self.userId = nil
        self.companyId = nil
        self.isAuthenticated = false
    }
}
