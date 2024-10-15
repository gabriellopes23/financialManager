
import SwiftUI

struct CreditCardsModel: Identifiable, Codable, Equatable {
    let id = UUID().uuidString
    var userId: String
    var amount: Double
    var numberCard: String
    var valid: String
    var typeCard: CreditCardType
    var invoiceDueDate: Int
    
    enum CodingKeys: String, CodingKey {
        case id, userId, amount, numberCard, valid, typeCard, invoiceDueDate
    }
}

