
import Foundation
import FirebaseAuth

class RegistrationViewModel {
    
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
            return (false, "A senha deve ter pelo menos \(minPasswordLength) caracteres, incluindo letras maiúsculas, minúsculas, números e caracteres especiais.")
        } else if password != repeatPassword {
            return (false, "As senhas não coincidem")
        } else {
            return (true, "Email e senha válidos")
        }
    }
}
