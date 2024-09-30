
import Foundation

enum CreditCardType: CaseIterable {
    case visa, mastercard, hipercard, elo
    
    var title: String {
        switch self {
        case .visa:
            return "Visa"
        case .mastercard:
            return "MasterCard"
        case .hipercard:
            return "HiperCard"
        case .elo:
            return "Elo"
        }
    }
    
    var image: String {
        switch self {
        case .visa:
            return "visaLogo"
        case .mastercard:
            return "mastercardLogo"
        case .hipercard:
            return "hipercardLogo"
        case .elo:
            return "eloLogo"
        }
    }
}



