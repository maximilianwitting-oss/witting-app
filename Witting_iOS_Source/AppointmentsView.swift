import SwiftUI

struct AppointmentsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear.ignoresSafeArea() // Let the TabView background show through
                
                ScrollView {
                    VStack(spacing: 20) {
                        AppointmentRow(title: "Website Relaunch", date: "20. April 2026", status: "Neu", color: .cyan)
                        AppointmentRow(title: "Netzwerk Troubleshooting", date: "22. April 2026", status: "Bestätigt", color: .blue)
                        AppointmentRow(title: "Backup Check", date: "10. April 2026", status: "Abgeschlossen", color: .green)
                    }
                    .padding()
                }
            }
            .navigationTitle("Termine")
        }
        // Transparent navigation bar
        .onAppear {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }
    }
}

struct AppointmentRow: View {
    var title: String
    var date: String
    var status: String
    var color: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(date)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
            Spacer()
            Text(status)
                .font(.caption.bold())
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(color.opacity(0.3))
                .foregroundColor(color)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(color.opacity(0.5), lineWidth: 1))
        }
        .glassCard()
    }
}
