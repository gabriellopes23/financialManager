
import Foundation

class CreditCardsViewModel: ObservableObject {
    
    @Published var creditCards: [CreditCardsModel] = []
    
    func addCreditCard(amount: Double, numberCard: String, valid: String, typeCard: CreditCardType) {
        
        let creditCard = CreditCardsModel(amount: amount, numberCard: numberCard, valid: valid, typeCard: typeCard)
        
        creditCards.append(creditCard)
    }
    
    func subtractFromCard(_ creditCard: CreditCardsModel, amount: Double) {
        
        if let index = creditCards.firstIndex(where: { $0.id == creditCard.id}) {
            creditCards[index].amount -= amount
        }
    }
    
}
