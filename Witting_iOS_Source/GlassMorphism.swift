import SwiftUI

struct GlassCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(LinearGradient(colors: [.white.opacity(0.5), .clear, .white.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.15), radius: 15, x: 0, y: 10)
    }
}

extension View {
    func glassCard() -> some View {
        self.modifier(GlassCard())
    }
}

struct LiquidBackground: View {
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.1, blue: 0.25).ignoresSafeArea() // Deep Ocean Blue
            
            // Neon glowing orbs to simulate liquid
            Circle()
                .fill(Color.blue.opacity(0.6))
                .blur(radius: 100)
                .frame(width: 300, height: 300)
                .offset(x: -100, y: -200)
            
            Circle()
                .fill(Color.cyan.opacity(0.5))
                .blur(radius: 120)
                .frame(width: 350, height: 350)
                .offset(x: 150, y: 200)
                
            Circle()
                .fill(Color.purple.opacity(0.4))
                .blur(radius: 150)
                .frame(width: 400, height: 400)
                .offset(x: -50, y: 400)
        }
    }
}
