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
                Text("Urgência: \(urgency.capitalized)")
                    .font(.caption)
                    .foregroundColor(colorForUrgency(urgency))
            }
            if let desc = card.description, !desc.isEmpty {
                Text(desc)
                    .font(.body)
            }
            if let subgroup = card.subgroup, !subgroup.isEmpty {
                Text("Subgrupo: \(subgroup.capitalized)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
    
    func colorForUrgency(_ urgency: String) -> Color {
        switch urgency.lowercased() {
        case "urgente":
            return .red
        case "normal":
            return .orange
        case "rotina":
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
            title: "Exemplo de Atividade",
            description: "Descrição da atividade.",
            status: "nova",
            createdBy: "1",
            createdAt: "2025-04-14 13:00:00",
            company: "Empresa Exemplo",
            urgency: "urgente",
            subgroup: "estrutura"
        )
        return CardView(card: exampleCard)
            .previewLayout(.sizeThatFits)
    }
}
