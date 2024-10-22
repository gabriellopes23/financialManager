
import SwiftUI
import FirebaseFirestore

@MainActor
class CreditCardsViewModel: ObservableObject {
    
    @Published var creditCards: [CreditCardsModel] = []
    
    func addCreditCard(amount: Double, numberCard: String, valid: String, typeCard: CreditCardType, userId: String, invoiceDueDate: Int) async throws {
        let creditCard = CreditCardsModel(userId: userId, amount: amount, numberCard: numberCard, valid: valid, typeCard: typeCard, invoiceDueDate: invoiceDueDate)
        
        do {
            let cardData = try Firestore.Encoder().encode(creditCard)
            try await Firestore.firestore().collection("creditCards").document(creditCard.id).setData(cardData)
            creditCards.append(creditCard)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func subtractFromCard(_ creditCard: CreditCardsModel, amount: Double) async throws {
        let cardRef = Firestore.firestore().collection("creditCards")
        
        let querySnapshot = try await cardRef.whereField("userId", isEqualTo: creditCard.userId).getDocuments()
        
        if let document = querySnapshot.documents.first {
            // Atualizar localmente o saldo do cartão
            if let index = creditCards.firstIndex(where: { $0.id == creditCard.id }) {
                creditCards[index].amount -= amount
                
                // Atualizar o saldo do cartão no Firestore
                let updatedAmount = creditCards[index].amount
                let cardData: [String: Any] = ["amount": updatedAmount]
                
                try await Firestore.firestore().collection("creditCards").document(document.documentID).updateData(cardData)
            }
        } else {
            print("Documento não encontrado: \(creditCard.userId)")
        }
    }
    
    func updateCreditCard(creditCard: CreditCardsModel, amount: Double) async throws {
        let cardData = try Firestore.Encoder().encode(creditCard)
        
        try await Firestore.firestore().collection("creditCards").document(creditCard.id).updateData(cardData)
        
        if let index = creditCards.firstIndex(where: { $0.id == creditCard.id }) {
            creditCards[index].amount += amount
        }
    }
    
    func deleteCreditCard(creditCard: CreditCardsModel) async throws {
        
        let cardRef = Firestore.firestore().collection("creditCards")
        
        let querySnapshot = try await cardRef.whereField("userId", isEqualTo: creditCard.userId).getDocuments()
        
        if let document = querySnapshot.documents.first {
            
            if let index = creditCards.firstIndex(where: { $0.id == creditCard.id }) {
                creditCards.remove(at: index)
                
                try await Firestore.firestore().collection("creditCards").document(document.documentID).delete()
            }
        } else {
            print("CreditCard não deletado")
        }
    }
    
    func fetchUserCreditCards(userId: String) async throws {
        let snapshot = try await Firestore.firestore().collection("creditCards").whereField("userId", isEqualTo: userId).getDocuments()
        
        self.creditCards = try snapshot.documents.compactMap { try $0.data(as: CreditCardsModel.self) }
    }
    
}
