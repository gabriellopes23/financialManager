
import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

@MainActor
class AuthService: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var crediCardVM = CreditCardsViewModel()
    
    @AppStorage("userName") var userName: String = ""
    @AppStorage("profileImage") var profileImageUrl: URL?

    func updateUserSession() {
        Task {
            userSession = Auth.auth().currentUser
            
            if let user = userSession {
                await loadUserDetails(userId: user.uid)
                await loadUserCreditCards(userId: user.uid)
            }
        }
    }
    
    
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            
            if let user = userSession {
                await loadUserDetails(userId: user.uid)
                await loadUserCreditCards(userId: user.uid)
            }
        } catch {
            throw error
        }
    }
    
    func loginWithGoogle(credential: AuthCredential) async throws {
        do {
            let result = try await Auth.auth().signIn(with: credential)
            self.userSession = result.user
            
            if let user = userSession {
                await loadUserDetails(userId: user.uid)
                await loadUserCreditCards(userId: user.uid)
            }
        } catch {
            throw error
        }
    }
    
    func createUser(withEmail email: String, name: String, password: String, repeatPassword: String, profileImage: String?) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(withEmail: email, id: result.user.uid, name: name, profileImage: profileImage)
            await loadUserCreditCards(userId: result.user.uid)
        } catch {
            print(error)
            throw error
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        
        userName = ""
        profileImageUrl = nil
    }
    
    func resetPassword(email: String, resetCompletion: @escaping (Result<Bool,Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                resetCompletion(.failure(error))
            } else {
                resetCompletion(.success(true))
            }
        }
    }
    
    func uploadProfileImage(_ image: UIImage) async throws {
        guard let userId = userSession?.uid else { return }
        let storageRef = Storage.storage().reference().child("profile_image/\(userId).jpg")
        
        do {
            guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let _ = try await storageRef.putDataAsync(imageData, metadata: metadata)
            let downloadURL = try await storageRef.downloadURL()
            
            
            try await UserService().updateUserProfileImage(userId: userId, url: downloadURL.absoluteString)
            
            profileImageUrl = downloadURL
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updataUserName(newUserName: String) async throws {
        guard let userId = userSession?.uid else { return }
        
        try await UserService().updateUserName(userId: userId, userName: newUserName)
        
        self.userName = newUserName
    }
    
    private func uploadUserData(withEmail email: String, id: String, name: String, profileImage: String?) async throws {
        let user = UserModel(id: id, name: name, email: email, profileImage: profileImage)
        try await UserService().uploadUserData(user)
        
        userName = name
        if let profileImage = profileImage, let url = URL(string: profileImage) {
            profileImageUrl = url
        }
    }
    
    private func loadUserDetails(userId: String) async {
        do {
            let user = try await UserService().fetchUserById(userId: userId)
            userName = user?.name ?? ""
            if let profileImage = user?.profileImage, let url = URL(string: profileImage) {
                profileImageUrl = url
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func loadUserCreditCards(userId: String) async {
        do {
            try await crediCardVM.fetchUserCreditCards(userId: userId)
        } catch {
            print(error.localizedDescription)
        }
    }
}
