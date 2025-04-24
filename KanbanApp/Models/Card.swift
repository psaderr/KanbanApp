import Foundation

struct Card: Codable, Identifiable {
    let id: String
    let title: String
    let description: String?
    let status: String      // Exemplo: "nova", "pendente", "execucao", "finalizada"
    let createdBy: String
    let createdAt: String
    let company: String?    // Valor atribuído pelo backend durante o login ou via join na consulta
    let urgency: String?    // "urgente", "normal", ou "rotina"
    let subgroup: String?   // Ex.: "financeira", "estrutura", "logica" ou vazio se não houver
}
