import SwiftUI

struct EmergencyButton: View {
    var body: some View {
        Button(action: {
            let email = "kontakt@witting.info"
            let subject = "NOTFALL:%20IT%20Support%20benötigt"
            if let url = URL(string: "mailto:\(email)?subject=\(subject)") {
                UIApplication.shared.open(url)
            }
        }) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 65, height: 65)
                .background(
                    LinearGradient(colors: [.red, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(.white.opacity(0.4), lineWidth: 2)
                )
                .shadow(color: .red.opacity(0.5), radius: 15, x: 0, y: 8)
        }
    }
}
