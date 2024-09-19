
import Foundation
import FirebaseAuth
import Combine

@MainActor
class ContentViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    
    private var authService: AuthService
    private var cancellables = Set<AnyCancellable>()
    
    init(authService: AuthService) {
        self.authService = authService
        
        setupSubscribres()
        authService.updateUserSession()
    }
    
    private func setupSubscribres() {
        authService.$userSession.sink { [weak self] user in
            self?.userSession = user
        }.store(in: &cancellables)
    }
}
