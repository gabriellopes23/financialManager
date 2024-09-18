
import Foundation
import FirebaseAuth

@MainActor
class AuthService {
    @Published var userSession: FirebaseAuth.User?
    
    func updateUserSession() {
        self.userSession = Auth.auth().currentUser
    }
    
    func createUser(withEmail email: String, name: String, password: String, repeatPassword: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(withEmail: email, id: result.user.uid, name: name)
        } catch {
            print(error)
            throw error
        }
    }
    
    private func uploadUserData(withEmail email: String, id: String, name: String) async throws {
        let user = UserModel(id: id, name: name, email: email)
        try await UserService().uploadUserData(user)
    }
}
