
import Foundation

enum TabbedItems: Int, CaseIterable {
    case home = 0
    case report
    case trasaction
    case account
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .report:
            return "Report"
        case .trasaction:
            return "Transaction"
        case .account:
            return "Account"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .report:
            return "chart.bar.fill"
        case .trasaction:
            return "arrow.left.arrow.right"
        case .account:
            return "person"
        }
    }
}
