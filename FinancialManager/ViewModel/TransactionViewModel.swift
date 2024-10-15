
import SwiftUI
import FirebaseFirestore

@MainActor
class TransactionViewModel: ObservableObject {
    @Published var totalBalance: Double = 0.0
    @Published var creditCardDebit: Double = 0.0
    @Published var transactions: [TransactionModel] = []
    
    private var creditCard: CreditCardsViewModel
    
    init(creditCard: CreditCardsViewModel) {
            self.creditCard = creditCard
        }
    
    func addTransaction(_ transaction: TransactionModel) async throws {
        // Se a transação for da conta
        if transaction.fromAccount == .account {
            // Atualiza o totalBalance baseado no tipo da transação
            if transaction.type == .income {
                totalBalance += transaction.amount
            } else if transaction.type == .expense {
                totalBalance -= transaction.amount
            }
        }
        // Se a transação for do cartão de crédito
        else if transaction.fromAccount == .creditCard {
            // Verifica se existe um cartão correspondente
            if let cardIndex = creditCard.creditCards.firstIndex(where: { $0.userId == transaction.userId }) {
                if transaction.type == .expense {
                    // Subtrai o valor do cartão de crédito apenas se for uma despesa
                    creditCard.creditCards[cardIndex].amount -= transaction.amount
                }
                // Se for uma receita, não faz nada, pois receitas não afetam o saldo do cartão
            }
        }
        
        do {
            let transactionData = try Firestore.Encoder().encode(transaction)
            try await Firestore.firestore().collection("transactions").document(transaction.id).setData(transactionData)
            transactions.append(transaction)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteTransaction(transaction: TransactionModel) async throws {
        let transactionRef = Firestore.firestore().collection("transactions")
        
        let querySnapshot = try await transactionRef.whereField("userId", isEqualTo: transaction.userId).getDocuments()
        
        if let document = querySnapshot.documents.first {
            if let index = transactions.firstIndex(where: { $0.id == transaction.id }) {
                transactions.remove(at: index)
                
                if transaction.fromAccount == .account {
                    // Apenas atualiza o saldo da conta se for uma transação de conta
                    totalBalance += transaction.type == .income ? transaction.amount : -transaction.amount
                } else if transaction.fromAccount == .creditCard {
                    // Caso seja uma transação de cartão de crédito, restaurar o valor no cartão
                    if let cardIndex = creditCard.creditCards.firstIndex(where: { $0.userId == transaction.userId }) {
                        creditCard.creditCards[cardIndex].amount += transaction.amount
                    }
                }
                
                try await Firestore.firestore().collection("transactions").document(document.documentID).delete()
            }
        } else {
            print("Transação não deletada")
        }
    }
    
    func fetchTransaction(userId: String) async throws {
        let snapshot = try await Firestore.firestore().collection("transactions").whereField("userId", isEqualTo: userId).getDocuments()
        self.transactions = try snapshot.documents.compactMap { try $0.data(as: TransactionModel.self) }
        
        self.totalBalance = transactions.reduce(0.0) { partialResult, transaction in
            if transaction.type == .income {
                return partialResult + transaction.amount
            } else {
                return partialResult - transaction.amount
            }
        }
    }
}

enum TimePeriod {
    case day, week, month, year
}
