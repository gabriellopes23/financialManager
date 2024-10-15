
import SwiftUI

struct ActivitiesView: View {
    
    let iconName: String
    let title: String
    let date: String
    let amount: String
    
    @Binding var deleteActivity: Bool
    @EnvironmentObject var transactionVM: TransactionViewModel
    @EnvironmentObject var creditCard: CreditCardsViewModel
    
    let deleteTransaction: TransactionModel?
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: iconName)
                    .padding(10)
                    .imageScale(.large)
                    .background(Circle().fill(.white.opacity(0.7)))
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.black)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    Text(date)
                        .font(.subheadline)
                }
                Spacer()
                Text(amount)
                    .font(.title3)
                    .fontWeight(.bold)
                
                if deleteActivity {
                    Button {
                        Task {
                            if let transaction = deleteTransaction {
                                try await transactionVM.deleteTransaction(transaction: transaction)
                            }
                        }
                    } label: {
                        Image(systemName: "trash")
                            .padding()
                    }

                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(colors: [.indigo, .blue.opacity(0.4), .indigo.opacity(0.7)], startPoint: .bottomLeading, endPoint: .topTrailing)))
            .foregroundStyle(.white)
        }
    }
}

