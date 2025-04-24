import Foundation

struct Card: Codable, Identifiable {
    let id: String
    let title: String
    let description: String?
    let status: String
    let createdBy: String
    let createdAt: String
}
