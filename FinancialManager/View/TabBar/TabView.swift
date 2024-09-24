
import SwiftUI

struct TabView: View {
    
    @State private var selectedTab: Int = 0
    
    private var authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    var body: some View {
        VStack {
            switch selectedTab {
            case TabbedItems.home.rawValue:
                HomeView()
            case TabbedItems.report.rawValue:
                ReportView()
            case TabbedItems.trasaction.rawValue:
                Text("Transaction")
            case TabbedItems.account.rawValue:
                AccountView(authService: authService)
            default:
                HomeView()
            }
            Spacer()
            ZStack {
                HStack {
                    ForEach((TabbedItems.allCases), id: \.self) { item in
                        Button {
                            selectedTab = item.rawValue
                        } label: {
                            customTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
            }
            .padding(6)
            .frame(height: 70)
            .background(RoundedRectangle(cornerRadius: 35).fill(.gray))
            .padding(.horizontal)
        }
    }
}

#Preview {
    TabView(authService: AuthService())
}
