
import SwiftUI

struct CreditCardsModel: Identifiable, Codable, Equatable {
    let id = UUID().uuidString
    var userId: String
    var amount: Double
    let numberCard: String
    let valid: String
    let typeCard: CreditCardType
     // Keep nested arrays for in-app representation
    
    enum CodingKeys: String, CodingKey {
        case id, userId, amount, numberCard, valid, typeCard
    }
}

