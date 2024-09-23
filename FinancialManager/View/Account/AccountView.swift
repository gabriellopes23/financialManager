
import SwiftUI

struct AccountView: View {
    
    @State private var showAlert: Bool = false
    
    private var authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    var body: some View {
        VStack(spacing: 25) {
            VStack {
                // Foto do usuário
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding()
                    .background(Circle().fill(.gray.opacity(0.6)))
                
                // nome do usuário
                Text("Gabriel Lopes")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            VStack(spacing: 20) {
                ButtonActionAccount(title: "Change Name", imageName: "pencil", color: .green) { }
                ButtonActionAccount(title: "Change Photo", imageName: "camera", color: .blue) { }
                ButtonActionAccount(title: "Change Password", imageName: "lock", color: .purple) { }
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
    }
}

#Preview {
    AccountView(authService: AuthService())
}
