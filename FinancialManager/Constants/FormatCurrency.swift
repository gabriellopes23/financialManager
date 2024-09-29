
import Foundation

func formatCurrency(_ amount: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    
    if let formatterAmount = formatter.string(from: NSNumber(value: amount)) {
        return formatterAmount
    } else {
        return "\(amount)"
    }
}
