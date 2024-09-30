
import Foundation

struct CreditCardsModel: Identifiable, Equatable {
    let id = UUID()
    
    var amount: Double
    let numberCard: String
    let valid: String
    let typeCard: CreditCardType
}
