
import SwiftUI

struct CreditCardsView: View {

    let amount: String
    let numberCard: String
    let valid: String
    let type: CreditCardType
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Balance")
                Text(amount)
                    .font(.title3)
                    .fontWeight(.bold)
                
                HStack {
                    Text("xxxx xxxx xxxx")
                        .font(.footnote)
                    Text(numberCard)
                        .font(.footnote)
                }
                Text("Valid Until \(valid)")
                    .font(.footnote)
            }
            Spacer()
            Image(type.image)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 30)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(
            LinearGradient(
                colors: [.blue, .indigo, .blue],
                startPoint: .bottomLeading, endPoint: .topTrailing)))
        .frame(width: 250, height: 150)
        .foregroundStyle(.white)
        
    }
}

#Preview {
    CreditCardsView(amount: "R$1.250,00", numberCard: "xxxx xxxx xxxx 0000", valid: "09/27", type: .visa)
}
