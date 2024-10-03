
import SwiftUI
import FirebaseFirestore

@MainActor
class CreditCardsViewModel: ObservableObject {
    
    @Published var creditCards: [CreditCardsModel] = []
    
    func addCreditCard(amount: Double, numberCard: String, valid: String, typeCard: CreditCardType, userId: String) async throws {
        let creditCard = CreditCardsModel(userId: userId, amount: amount, numberCard: numberCard, valid: valid, typeCard: typeCard)
        
        do {
            let cardData = try Firestore.Encoder().encode(creditCard)
            try await Firestore.firestore().collection("creditCards").document(creditCard.id).setData(cardData)
            creditCards.append(creditCard)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func subtractFromCard(_ creditCard: CreditCardsModel, amount: Double) async throws {
        
        if let index = creditCards.firstIndex(where: { $0.id == creditCard.id}) {
            creditCards[index].amount -= amount
            
            let cardData = try Firestore.Encoder().encode(creditCards[index])
            try await Firestore.firestore().collection("creditCards").document(creditCards[index].id).setData(cardData)
        }
    }
    
    func fetchUserCreditCards(userId: String) async throws {
        let snapshot = try await Firestore.firestore().collection("creditCards").whereField("userId", isEqualTo: userId).getDocuments()
        self.creditCards = try snapshot.documents.compactMap { try $0.data(as: CreditCardsModel.self) }
    }
    
}
