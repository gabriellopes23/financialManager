
import Foundation
import FirebaseFirestore

@MainActor
class TransactionViewModel: ObservableObject {
    @Published var totalBalance: Double = 0.0
    @Published var creditCardDebit: Double = 0.0
    @Published var transactions: [TransactionModel] = []
    
    func addTransaction(_ transaction: TransactionModel) async throws {
        
        if transaction.fromAccount == .account {
            totalBalance += transaction.type == .income ? transaction.amount : -transaction.amount
        }
        
        do {
            let transactionData = try Firestore.Encoder().encode(transaction)
            try await Firestore.firestore().collection("transactions").document(transaction.id).setData(transactionData)
            transactions.append(transaction)
        } catch {
            print(error.localizedDescription)
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
