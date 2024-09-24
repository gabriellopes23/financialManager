
import SwiftUI

struct CardTransactionView: View {
    
    let value: String
    let colors: [Color]
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("CARD BALANCE")
                    .font(.footnote)
                    .fontWeight(.semibold)
                Text(value)
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 10) {
                Text("** 0000")
                    .font(.footnote)
                Text("VISA")
                    .font(.title3)
                    .fontWeight(.heavy)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(
            LinearGradient(
                colors: colors,
                startPoint: .bottomLeading, endPoint: .topTrailing)))
        .frame(maxWidth: .infinity, maxHeight: 80)
        .foregroundStyle(.white)
    }
}

#Preview {
    CardTransactionView(value: "R$1.250,00", colors: [.indigo, .blue, .blue.opacity(0.7)])
}
