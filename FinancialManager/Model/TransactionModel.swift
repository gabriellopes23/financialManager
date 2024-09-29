
import Foundation

struct TransactionModel: Identifiable {
    var id = UUID()
    var title: String
    var iconName: String
    var amount: Double
    var type: TransactionType
    var date: Date
    var fromAccount: AccountType
    
    enum TransactionType {
        case income, expense
    }
    
    enum AccountType {
        case account, creditCard
    }
}
