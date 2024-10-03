
import SwiftUI
import PhotosUI
import FirebaseStorage

struct AccountView: View {
    
    @State private var userName: String = ""
    @State private var showAlert: Bool = false
    @State private var showPicker: Bool = false
    @State private var profileImage: UIImage?
    @State private var isUploading: Bool = false
    @State private var downloadURL: URL?
    @State private var isEditingName: Bool = false
    @State private var showForgotPassword: Bool = false
    
    private var authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    var body: some View {
        VStack(spacing: 25) {
            VStack {
                // Foto do usuário
                if let imageUrl = authService.profileImageUrl {
                    ImageFromURL(url: imageUrl) // Carregar a imagem localmente
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding()
                        .background(Circle().fill(.gray.opacity(0.6)))
                }
                
                
                // nome do usuário
                if isEditingName {
                    HStack {
                        TextField("UserName", text: $userName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Button {
                            Task {
                                try await authService.updataUserName(newUserName: userName)
                                isEditingName = false
                            }
                        } label: {
                            Image(systemName: "checkmark")
                                .padding()
                        }
                    }
                    
                } else {
                    Text("\(authService.userName)")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            
            VStack(spacing: 20) {
                ButtonActionAccount(title: "Change Name", imageName: "pencil", color: .green) {
                    isEditingName = true
                }
                ButtonActionAccount(title: "Change Photo", imageName: "camera", color: .blue) {
                    showPicker = true
                }
                ButtonActionAccount(title: "Change Password", imageName: "lock", color: .purple) {
                    showForgotPassword = true
                }
                ButtonActionAccount(title: "Notifications", imageName: "bell", color: .orange) { }
                ButtonActionAccount(title: "Logout", imageName: "iphone.and.arrow.right.outward", color: .red) {
                    showAlert = true
                }
            }
        }
        .alert("Confirm Logout", isPresented: $showAlert) {
            Button("Logout", role: .destructive) {
                authService.signOut()
            }
            
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to log out?")
        }
        .sheet(isPresented: $showPicker, content: {
            ImagePicker(image: $profileImage)
                .onDisappear {
                    if let image = profileImage {
                        Task {
                            try await authService.uploadProfileImage(image)
                        }
                    }
                }
        })
        .sheet(isPresented: $showForgotPassword) {
            NavigationStack {
                ResetPasswordView(authService: authService)
            }
            .presentationDetents([.fraction(0.3)])
            .presentationCornerRadius(50)
        }
    }
}

#Preview {
    AccountView(authService: AuthService())
}
