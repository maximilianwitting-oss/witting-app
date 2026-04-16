import SwiftUI

struct ContentView: View {
    init() {
        // Transparent TabBar for the glass effect
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ZStack {
            LiquidBackground()
            
            TabView {
                DashboardView()
                    .tabItem {
                        Label("Dashboard", systemImage: "square.grid.2x2.fill")
                    }
                
                AppointmentsView()
                    .tabItem {
                        Label("Termine", systemImage: "calendar")
                    }
                
                InvoicesView()
                    .tabItem {
                        Label("Rechnungen", systemImage: "doc.text.fill")
                    }
            }
            .tint(.cyan)
            
            // Floating Emergency Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    EmergencyButton()
                        .padding(.trailing, 20)
                        .padding(.bottom, 90)
                }
            }
        }
    }
}
