import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(card.title)
                .font(.headline)
            if let company = card.company, !company.isEmpty {
                Text("Empresa: \(company)")
                    .font(.subheadline)
            }
            if let urgency = card.urgency, !urgency.isEmpty {
                Text("Urgência: \(urgency)")
                    .font(.caption)
                    .foregroundColor(colorForUrgency(urgency))
            }
            if let desc = card.description, !desc.isEmpty {
                Text(desc)
                    .font(.body)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
    
    func colorForUrgency(_ urgency: String) -> Color {
        switch urgency.lowercased() {
        case "alta":
            return .red
        case "média", "media":
            return .orange
        case "baixa":
            return .green
        default:
            return .gray
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleCard = Card(
            id: "1",
            title: "Exemplo de Card",
            description: "Esta é a descrição do card.",
            status: "ToDo",
            createdBy: "User123",
            createdAt: "2025-04-14",
            company: "Exemplo Co.",
            urgency: "Alta"
        )
        return CardView(card: exampleCard)
            .previewLayout(.sizeThatFits)
    }
}
