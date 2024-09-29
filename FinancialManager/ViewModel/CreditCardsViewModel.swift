
import Foundation

class CreditCardsViewModel: ObservableObject {
    
    @Published var creditCards: [CreditCardsModel] = []
    
    func addCreditCard(amount: Double, numberCard: String, valid: String, type: CreditCardsModel.TypeCards) {
        
        let creditCard = CreditCardsModel(amount: amount, numberCard: numberCard, valid: valid, type: type)
        
        creditCards.append(creditCard)
    }
    
}
