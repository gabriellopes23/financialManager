
import Foundation
import FirebaseAuth
import FirebaseFirestore

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
}
