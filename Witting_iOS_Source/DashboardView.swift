import SwiftUI

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Willkommen zurück,")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                        Text("Max")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Image(systemName: "applelogo")
                        .font(.title)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.top, 40)
                
                // Next Appointment Card
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "calendar.badge.clock")
                            .foregroundColor(.cyan)
                        Text("Nächster Termin")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                        Text("Morgen, 14:00")
                            .font(.caption)
                            .padding(8)
                            .background(.white.opacity(0.2))
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                    }
                    
                    Text("Mac Server Setup & MDM")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                    Text("Kreativagentur Müller GmbH")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                .glassCard()
                
                // Quick Stats
                HStack(spacing: 20) {
                    StatCard(icon: "checkmark.circle.fill", title: "Erledigt", value: "12", color: .green)
                    StatCard(icon: "eurosign.circle.fill", title: "Offen", value: "3", color: .orange)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

struct StatCard: View {
    var icon: String
    var title: String
    var value: String
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            Text(value)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            Text(title)
                .font(.footnote)
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassCard()
    }
}
