
import Foundation

struct CreditCardsModel: Identifiable, Equatable {
    let id = UUID()
    
    var amount: Double
    let numberCard: String
    let valid: String
    let type: TypeCards
    
    enum TypeCards {
        case visa, mastercard, elo, hibercard
    }
}
