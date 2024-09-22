
import SwiftUI

struct ResetPasswordView: View {
    
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var errString: String? = nil
    
    private var authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    var body: some View {
        VStack {
            TextFieldLoginAndSignup(imageName: "envelope", titleTextField: "Email address", text: $email)
            
            Button {
                authService.resetPassword(email: email) { (result) in
                    switch result {
                    case .failure(let error):
                        errString = error.localizedDescription
                    case .success( _):
                        break
                    }
                    showAlert = true
                }
            } label: {
                Text("Reset password")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 20).fill(principalColor))
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Reset password")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Password Reset"), message: Text(errString ?? "Success. Reet email sent successfully. Check your email"), dismissButton: .default(Text("Ok")))
        }
    }
}

#Preview {
    ResetPasswordView(authService: AuthService())
}
