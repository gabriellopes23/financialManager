
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
        if authService.userSession != nil {
            TabView(authService: authService)
        } else {
            AuthenticationView(authService: authService)
        }
    }
}

#Preview {
    ContentView(authService: AuthService())
}
