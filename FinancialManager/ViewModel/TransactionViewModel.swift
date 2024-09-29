
import Foundation

class TransactionViewModel: ObservableObject {
    @Published var totalBalance: Double = 0.0
    @Published var creditCardDebit: Double = 0.0
    @Published var transactions: [TransactionModel] = []
    
    func addTransaction(_ transaction: TransactionModel) {
        
        if transaction.fromAccount == .account {
            totalBalance += transaction.type == .income ? transaction.amount : -transaction.amount
        }
        
        transactions.append(transaction)
    }
    
}
