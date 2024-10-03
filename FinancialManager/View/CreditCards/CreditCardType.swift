
import Foundation

enum CreditCardType: String, Codable, CaseIterable {
    case visa = "Visa"
    case  mastercard = "MasterCard"
    case  hipercard = "HiperCard"
    case  elo = "Elo"
    
    var title: String {
        return self.rawValue
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



