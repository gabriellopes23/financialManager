
import Foundation

struct TransactionModel: Identifiable, Codable {
    var id = UUID().uuidString
    
    var userId: String
    var title: String
    var iconName: String
    var amount: Double
    var type: TransactionType
    var date: Date
    var fromAccount: AccountType
    
    enum TransactionType: Codable {
        case income, expense
    }
    
    enum AccountType: Codable {
        case account, creditCard
    }
}
