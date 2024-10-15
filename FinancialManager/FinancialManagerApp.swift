
import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct YourApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private var authService = AuthService()
    
    @StateObject private var transactionVM = TransactionViewModel(creditCard: CreditCardsViewModel())
    @StateObject private var creditCardVM = CreditCardsViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(authService: authService)
                    .environmentObject(transactionVM)
                    .environmentObject(creditCardVM)
            }
        }
    }
}
