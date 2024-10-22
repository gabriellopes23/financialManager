
import SwiftUI

struct TotalBalanceTransactionView: View {
    
    @EnvironmentObject var transactionVM: TransactionViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("TOTAL BALANCE")
                    .font(.footnote)
                    .fontWeight(.semibold)
                Text(formatCurrency(transactionVM.totalBalance))
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
        }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(
                LinearGradient(
                    colors: [.indigo, .blue, .blue.opacity(0.7)],
                    startPoint: .bottomLeading, endPoint: .topTrailing)))
            .frame(maxWidth: .infinity, maxHeight: 80)
            .foregroundStyle(.white)
            .padding(.top)
    }
}

#Preview {
    TotalBalanceTransactionView()
        .environmentObject(TransactionViewModel(creditCardVM: CreditCardsViewModel()))
}
