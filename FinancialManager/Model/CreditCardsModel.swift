
import Foundation

struct CreditCardsModel: Identifiable {
    let id = UUID()
    
    let amount: Double
    let numberCard: String
    let valid: String
    let type: TypeCards
    
    enum TypeCards {
        case visa, mastercard, elo, hibercard
    }
}
