
import SwiftUI

struct CreditCardsView: View {
    
    let amount: String
    let numberCard: String
    let valid: String
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Balance")
                Text(amount)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(numberCard)
                    .font(.footnote)
                Text("Valid Until \(valid)")
                    .font(.footnote)
            }
            Spacer()
//            Image(selecteTypeCard.image)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 60, height: 30)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(
            LinearGradient(
                colors: [.purple, .indigo, .blue.opacity(0.7)],
                startPoint: .bottomLeading, endPoint: .topTrailing)))
        .frame(width: 250, height: 150)
        .foregroundStyle(.white)
    }
}

#Preview {
    CreditCardsView(amount: "R$1.250,00", numberCard: "xxxx xxxx xxxx 0000", valid: "09/27")
}
