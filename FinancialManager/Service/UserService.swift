
import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct UserService {
    
    func uploadUserData(_ user: UserModel) async throws {
        do {
            let userData = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(userData)
        } catch {
            throw error
        }
    }
    
    func fetchUser() async throws -> [UserModel] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: UserModel.self) })
    }
    
    func fetchUserById(userId: String) async throws -> UserModel? {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        return try? snapshot.data(as: UserModel.self)
    }
    
    func updateUserProfileImage(userId: String, url: String) async throws {
        try await Firestore.firestore().collection("users").document(userId).updateData(["profileImage": url])
    }
    
    func updateUserName(userId: String, userName: String) async throws {
        try await Firestore.firestore().collection("users").document(userId).updateData(["name": userName])
    }
}
