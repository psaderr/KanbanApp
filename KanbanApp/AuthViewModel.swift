import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var userId: String? = nil
    
    // Função para efetuar login utilizando o NetworkManager
    func login(email: String, password: String) {
        NetworkManager.shared.login(email: email, password: password) { success, userId in
            DispatchQueue.main.async {
                if success, let uid = userId {
                    self.userId = uid
                    self.isAuthenticated = true
                } else {
                    self.isAuthenticated = false
                }
            }
        }
    }
    
    // (Opcional) função de logout
    func logout() {
        self.userId = nil
        self.isAuthenticated = false
    }
}
