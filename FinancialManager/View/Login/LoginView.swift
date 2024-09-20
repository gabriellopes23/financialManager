
import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    
    @State private var isLoginSelected: Bool = true
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var repeatPassword: String = ""
    
    @State private var showMessagerError: Bool = false
    @State private var messageError: String = ""
    @State private var showForgotPassword: Bool = false
    
    @StateObject var authenticationVM: AuthenticationViewModel
    
    private var authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
        
        let authenticationVM = AuthenticationViewModel(authService: authService)
        self._authenticationVM = StateObject(wrappedValue: authenticationVM)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Image ilustrativa do SpendWise
            Image(logoParaLogin)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.top)
            
            // Title
            HStack(spacing: 0) {
                Text("Spend")
                    .fontWeight(.bold)
                Text("Wise")
                    .fontWeight(.light)
            }
            .font(.largeTitle)
            
            // SubTitle
            VStack {
                Text("Welcome to SpendWise")
                    .fontWeight(.semibold)
                
                // Massage for login
                Text("Sign up or login below manage your finances.")
            }
            
            // Buttons login / Sign up
            HStack(spacing: 0) {
                Button {
                    withAnimation(.easeIn(duration: 0.2)) {
                        isLoginSelected = true
                    }
                } label: {
                    Text("Login")
                        .padding(10)
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(isLoginSelected ? .white : .black)
                .background(RoundedRectangle(cornerRadius: 20).fill(isLoginSelected ? principalColor : .clear))
                
                Button {
                    withAnimation(.easeIn(duration: 0.2)) {
                        isLoginSelected = false
                    }
                    
                } label: {
                    Text("Sign up")
                        .padding(10)
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(isLoginSelected ? .black : .white)
                .background(RoundedRectangle(cornerRadius: 20).fill(isLoginSelected ? .clear : principalColor))
                
            }
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 20).fill(.gray.opacity(0.7)))
            .padding(.horizontal)
            
            // Form login / sign up
            if isLoginSelected {
                VStack(spacing: 30) {
                    VStack {
                        TextFieldLoginAndSignup(imageName: "envelope", titleTextField: "Email address", text: $email)
                        SecureFieldLoginAndSignup(imageName: "lock", titleTextField: "Password", text: $password)
                        
                        if let errorMessage = authenticationVM.errorMessage {
                            Text(errorMessage)
                                .foregroundStyle(.red)
                        }
                    }
                    
                    // Button Login
                    Button {
                        Task {
                            await authenticationVM.login(withEmail: email, password: password)
                        }
                    } label: {
                        Text("Login")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(RoundedRectangle(cornerRadius: 20).fill(principalColor))
                            .padding(.horizontal)
                    }
                    
                    // Divider
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .opacity(0.5)
                        Text("Or")
                        Rectangle()
                            .frame(height: 1)
                            .opacity(0.5)
                    }
                    
                    // Button for Sign up
                    Button {
                        Task {
                            try await authenticationVM.loginWithGoogle()
                        }
                    } label: {
                        HStack {
                            Image(googleLogo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("Sing up using Google")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerRadius: 20).fill(principalColor))
                        .padding(.horizontal)
                    }
                    
                    // button para restaurar a senha
                    Button {
                        showForgotPassword = true
                    } label: {
                        Text("Forgot Password? click here")
                    }

                }
            } else {
                VStack {
                    VStack(spacing: 10) {
                        TextFieldLoginAndSignup(imageName: "person", titleTextField: "Full name", text: $name)
                        TextFieldLoginAndSignup(imageName: "envelope", titleTextField: "Email address", text: $email)
                        SecureFieldLoginAndSignup(imageName: "lock", titleTextField: "Password", text: $password)
                        SecureFieldLoginAndSignup(imageName: "lock", titleTextField: "Reapeat Password", text: $repeatPassword)
                        
                        if showMessagerError {
                            VStack {
                                Text(messageError)
                                    .foregroundStyle(.red)
                                    .minimumScaleFactor(0.7)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        Task {
                            let result = await authenticationVM.registrationUser(name: name, email: email, password: password, repeatPassword: repeatPassword)
                            
                            let error = result.1
                            messageError = error
                            showMessagerError = true
                        }
                    } label: {
                        Text("Sign up")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                            .background(RoundedRectangle(cornerRadius: 20).fill(principalColor))
                            .padding(.horizontal)
                    }
                }
            }
        }
        .sheet(isPresented: $showForgotPassword) {
            
        }
    }
}

#Preview {
    LoginView(authService: AuthService())
}
