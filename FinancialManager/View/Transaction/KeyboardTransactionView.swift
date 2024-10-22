
import SwiftUI

struct KeyboardTransactionView: View {
    
    @EnvironmentObject var creditCardVM: CreditCardsViewModel
    @EnvironmentObject var transactionVM: TransactionViewModel
    @EnvironmentObject var authService: AuthService
    @Binding var selectedItem: TransactionItems?
    
    @Binding var inputValue: String
    @Binding var isIncome: Bool?
    @Binding var showCreditCards: Bool
    
    var selectedCard: CreditCardsModel?
    
    
    let keys: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", "⌫"],
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Spacer()
            HStack(alignment: .bottom) {
                Text(inputValue.isEmpty ? "Digite um Valor" : inputValue)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button {
                    if let amount = Double(inputValue), let isIncome = isIncome, let userId = authService.userSession?.uid {
                        let transaction = TransactionModel(
                            userId: userId,
                            title: selectedItem?.title ?? "Receita",
                            iconName: selectedItem?.iconName ?? "dollarsign",
                            amount: amount,
                            type: isIncome ? .income : .expense,
                            date: Date(),
                            fromAccount: showCreditCards ? .creditCard : .account,
                            creditCard: selectedCard
                        )
                        
                        Task {
                            if transaction.fromAccount == .creditCard, !isIncome {
                                if let card = selectedCard {
                                    try await creditCardVM.subtractFromCard(card, amount: transaction.amount)
                                    try await transactionVM.addTransaction(transaction, selectedCard: selectedCard)
                                }
                            } else {
                                try await transactionVM.addTransaction(transaction, selectedCard: nil)
                            }
                        }
                    }
                    
                    inputValue = ""
                } label: {
                    Text("Enviar")
                        .padding()
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(width: 110, height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.red))
                }
            }
            .padding(.horizontal)
            
            VStack {
                ForEach(keys, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { key in
                            Button {
                                keyPress(key: key)
                            } label: {
                                Text(key)
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(textColor)
                            }
                            
                        }
                    }
                    
                }
            }
        }
    }
    
    func keyPress(key: String) {
        switch key {
        case "⌫":
            if !inputValue.isEmpty {
                inputValue.removeLast()
            }
        default:
            inputValue += key
        }
    }
}

#Preview {
    KeyboardTransactionView(selectedItem: .constant(.Alimentação), inputValue: .constant("57"), isIncome: .constant(true), showCreditCards: .constant(false), selectedCard: CreditCardsModel(userId: "", amount: 200, numberCard: "1234", valid: "12/23", typeCard: .visa, invoiceDueDate: 1))
        .environmentObject(TransactionViewModel(creditCardVM: CreditCardsViewModel()))
        .environmentObject(CreditCardsViewModel())
        .environmentObject(AuthService())
}
