
import Foundation
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

class AuthenticationViewModel: ObservableObject {

    private var authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func login(withEmail email: String, password: String) async {
        do {
            try await authService.login(withEmail: email, password: password)
        } catch {
            print(error)
        }
    }
    
    func loginWithGoogle() async throws {
        guard let topVC = await Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken = gidSignInResult.user.accessToken.tokenString
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: accessToken)
        
        do {
            try await authService.loginWithGoogle(credential: credential)
        } catch {
            print(error)
        }
    }
    
    func registrationUser(name: String, email: String, password: String, repeatPassword: String) async -> (Bool, String) {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValidEmail = emailPred.evaluate(with: email)
        
        let minPasswordLength = 8
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[#$^+=!*()@%&]).{8,}$"
        
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let isPasswordValid = passwordPred.evaluate(with: password)
        
        if name.isEmpty && email.isEmpty && password.isEmpty && repeatPassword.isEmpty {
            return (false, "Campos Inválidos")
        } else if !isValidEmail {
            return (false, "Email inválido")
        } else if !isPasswordValid {
            return (false, """
A senha deve ter pelo menos \(minPasswordLength) caracteres
incluindo letras maiúsculas, minúsculas, números e caracteres especiais.
""")
        } else if password != repeatPassword {
            return (false, "As senhas não coincidem")
        } else {
            do {
                try await authService.createUser(withEmail: email, name: name, password: password, repeatPassword: repeatPassword)
            } catch {
                print(error)
            }
            return (true, "Email e senha válidos")
        }
    }
}
