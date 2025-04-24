import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    // URL base para os endpoints da API (ajuste conforme necessário)
    let baseURL = "https://ahrsolucoes.com.br/kanban/api"
    
    // MARK: - LOGIN
    /// Efetua o login chamando "login.php" e espera um JSON contendo "status" e "userId" (e opcionalmente "company_id")
    func login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        guard let url = URL(string: "\(baseURL)/login.php") else {
            completion(false, nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "email=\(email)&password=\(password)"
        request.httpBody = bodyData.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Login error: \(error)")
                completion(false, nil)
                return
            }
            guard let data = data else {
                completion(false, nil)
                return
            }
            do {
                // Exemplo: {"status": "success", "userId": "123", "company_id": "2"}
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let status = json["status"] as? String,
                   status == "success",
                   let userId = json["userId"] as? String {
                    // Se precisar também retornar company_id, você pode capturá-lo aqui
                    // Por exemplo, você pode estender este método para retornar um dicionário ou criar outro callback
                    completion(true, userId)
                } else {
                    completion(false, nil)
                }
            } catch {
                print("Login JSON decoding error: \(error)")
                completion(false, nil)
            }
        }.resume()
    }
    
    // MARK: - LOGOUT
    func logout(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/logout.php") else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Logout error: \(error)")
                completion(false)
                return
            }
            completion(true)
        }.resume()
    }
    
    // MARK: - FETCH CARDS
    /// Recupera os cards chamando "get_tasks.php"
    func fetchCards(completion: @escaping ([Card]?) -> Void) {
        guard let url = URL(string: "\(baseURL)/get_tasks.php") else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Fetch Cards error: \(error)")
                DispatchQueue.main.async { completion(nil) }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            do {
                let cards = try JSONDecoder().decode([Card].self, from: data)
                DispatchQueue.main.async { completion(cards) }
            } catch {
                print("Decoding Cards error: \(error)")
                DispatchQueue.main.async { completion(nil) }
            }
        }.resume()
    }
    
    // MARK: - CREATE CARD
    /// Cria um novo card chamando "add_task.php".
    /// Envia: title, description, urgency, company_id, subgroup e user_id.
    func createCard(title: String, description: String?, urgency: String, companyId: String, subgroup: String, userId: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/add_task.php") else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var bodyData = "title=\(title)&user_id=\(userId)&company_id=\(companyId)&urgency=\(urgency)&subgroup=\(subgroup)"
        if let desc = description, !desc.isEmpty {
            bodyData += "&description=\(desc)"
        }
        request.httpBody = bodyData.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Create Card error: \(error)")
                DispatchQueue.main.async { completion(false) }
                return
            }
            DispatchQueue.main.async { completion(true) }
        }.resume()
    }
    
    // MARK: - UPDATE DESCRIPTION
    func updateDescription(taskId: String, newDescription: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/update_description.php") else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "id=\(taskId)&description=\(newDescription)"
        request.httpBody = bodyData.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Update Description error: \(error)")
                DispatchQueue.main.async { completion(false) }
                return
            }
            DispatchQueue.main.async { completion(true) }
        }.resume()
    }
    
    // MARK: - UPDATE STATUS
    func updateStatus(taskId: String, newStatus: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/update_status.php") else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "id=\(taskId)&status=\(newStatus)"
        request.httpBody = bodyData.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Update Status error: \(error)")
                DispatchQueue.main.async { completion(false) }
                return
            }
            DispatchQueue.main.async { completion(true) }
        }.resume()
    }
    
    // MARK: - REGISTER DEVICE (Push Notifications)
    func registerDevice(userId: String, token: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/register_device.php") else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "user_id=\(userId)&token=\(token)"
        request.httpBody = bodyData.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Register Device error: \(error)")
                DispatchQueue.main.async { completion(false) }
                return
            }
            DispatchQueue.main.async { completion(true) }
        }.resume()
    }
    
    // MARK: - OPTIONAL: ADD COMPANY
    func addCompany(name: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/add_company.php") else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "name=\(name)"
        request.httpBody = bodyData.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Add Company error: \(error)")
                DispatchQueue.main.async { completion(false) }
                return
            }
            DispatchQueue.main.async { completion(true) }
        }.resume()
    }
    
    // MARK: - OPTIONAL: GET ONLINE USERS
    func getOnlineUsers(completion: @escaping ([[String: Any]]?) -> Void) {
        guard let url = URL(string: "\(baseURL)/get_online_users.php") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Get Online Users error: \(error)")
                DispatchQueue.main.async { completion(nil) }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    DispatchQueue.main.async { completion(jsonArray) }
                } else {
                    DispatchQueue.main.async { completion(nil) }
                }
            } catch {
                print("Error decoding online users JSON: \(error)")
                DispatchQueue.main.async { completion(nil) }
            }
        }.resume()
    }
}
