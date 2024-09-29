
import SwiftUI
import SwiftData

struct KeyboardTransactionView: View {
    
    @EnvironmentObject var transactionVM: TransactionViewModel
    @Binding var selectedItem: TransactionItems?
    
    @Binding var inputValue: String
    @Binding var isIncome: Bool?
    
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
                    if isIncome == true {
                        transactionVM.addTransaction(TransactionModel(title: "Salário/Renda", iconName: "dollarsign", amount: Double(inputValue) ?? 0.0, type: .income, date: Date(), fromAccount: .account))
                    } else {
                        transactionVM.addTransaction(TransactionModel(title: selectedItem?.title ?? "", iconName: selectedItem?.iconName ?? "", amount: Double(inputValue) ?? 0.0, type: .expense, date: Date(), fromAccount: .account))
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
    KeyboardTransactionView(selectedItem: .constant(.Alimentação), inputValue: .constant("57"), isIncome: .constant(true))
        .environmentObject(TransactionViewModel())
}
