import SwiftUI

struct InvoicesView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        InvoiceRow(id: "RE-2026-042", client: "Kreativagentur Müller", amount: "450,00 €", isPaid: false)
                        InvoiceRow(id: "RE-2026-041", client: "Café Sonnenschein", amount: "120,00 €", isPaid: true)
                        InvoiceRow(id: "RE-2026-040", client: "Architekturbüro Meier", amount: "890,00 €", isPaid: true)
                    }
                    .padding()
                }
            }
            .navigationTitle("Rechnungen")
        }
    }
}

struct InvoiceRow: View {
    var id: String
    var client: String
    var amount: String
    var isPaid: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(client)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(id)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 5) {
                Text(amount)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(isPaid ? "Bezahlt" : "Offen")
                    .font(.caption2.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(isPaid ? Color.green.opacity(0.3) : Color.orange.opacity(0.3))
                    .foregroundColor(isPaid ? .green : .orange)
                    .clipShape(Capsule())
            }
        }
        .glassCard()
    }
}
