
import SwiftUI

struct ContentView: View {
    
    @StateObject var contentVM: ContentViewModel
    
    private var authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
        
        let contentVM = ContentViewModel(authService: authService)
        self._contentVM = StateObject(wrappedValue: contentVM)
    }
    
    var body: some View {
        Group {
             if authService.userSession != nil {
                TabBarView(authService: authService)
            } else {
                AuthenticationView(authService: authService)
            }
        }
        .onAppear {
            authService.updateUserSession()
        }
    }
}

#Preview {
    ContentView(authService: AuthService())
}
