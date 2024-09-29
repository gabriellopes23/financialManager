
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
        authService.$userSession
            .receive(on: DispatchQueue.main) // Receber atualizações no Main Thread
            .sink { [weak self] user in
                DispatchQueue.main.async {
                    self?.userSession = user
                }
            }
            .store(in: &cancellables)
    }
}
