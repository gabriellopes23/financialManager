
import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var transactionVM: TransactionViewModel
    @EnvironmentObject var creditCardVM: CreditCardsViewModel
    
    @State private var selectedTab: Int = 0
    
    private var authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
            
            VStack {
                switch selectedTab {
                case TabbedItems.home.rawValue:
                    HomeView()
                        .environmentObject(authService)
                case TabbedItems.report.rawValue:
                    ReportView()
                case TabbedItems.trasaction.rawValue:
                    TransactionView(authService: authService)
                case TabbedItems.account.rawValue:
                    AccountView(authService: authService)
                default:
                    HomeView()
                        .environmentObject(authService)
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
}

#Preview {
    TabBarView(authService: AuthService())
        .environmentObject(TransactionViewModel(creditCard: CreditCardsViewModel()))
        .environmentObject(CreditCardsViewModel())
}
