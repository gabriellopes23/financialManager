
import SwiftUI
import FirebaseFirestore

@MainActor
class TransactionViewModel: ObservableObject {
    @Published var totalBalance: Double = 0.0
    @Published var transactions: [TransactionModel] = []
    
    private var creditCardVM: CreditCardsViewModel
    
    init(creditCardVM: CreditCardsViewModel) {
        self.creditCardVM = creditCardVM
    }
    
    func addTransaction(_ transaction: TransactionModel, selectedCard: CreditCardsModel?) async throws {
            
            let transactionData = try Firestore.Encoder().encode(transaction)
            try await Firestore.firestore().collection("transactions").document(transaction.id).setData(transactionData)
            
            // Atualizar o saldo total apenas se a transação for da conta
            if transaction.fromAccount == .account {
                if transaction.type == .income {
                    totalBalance += transaction.amount
                } else {
                    totalBalance -= transaction.amount
                }
            }
            
            // Atualizar o saldo do cartão de crédito se a transação for feita nele
            if transaction.fromAccount == .creditCard, let selectedCard = selectedCard {
                if transaction.type == .income {
                    // Adicionar valor ao saldo do cartão
                    try await creditCardVM.updateCreditCard(creditCard: selectedCard, amount: transaction.amount)
                } else {
                    try await creditCardVM.updateCreditCard(creditCard: selectedCard, amount: -transaction.amount)
                }
            }
            
            transactions.append(transaction)
    }
    
    func deleteTransaction(transaction: TransactionModel) async throws {
        let transactionRef = Firestore.firestore().collection("transactions")
        
        let querySnapshot = try await transactionRef.whereField("userId", isEqualTo: transaction.userId).getDocuments()
        
        if let document = querySnapshot.documents.first {
            if let index = transactions.firstIndex(where: { $0.id == transaction.id }) {
                transactions.remove(at: index)
                
                 if transaction.fromAccount == .account {
                     // Ele retorna o valor para o totalBalance
                    totalBalance += transaction.type == .income ? transaction.amount : -transaction.amount
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
