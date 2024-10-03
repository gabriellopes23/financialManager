
import SwiftUI

struct UserModel: Identifiable, Codable {
    var id: String
    let name: String
    let email: String
    var profileImage: String? = nil
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case email
        case profileImage
    }
}
