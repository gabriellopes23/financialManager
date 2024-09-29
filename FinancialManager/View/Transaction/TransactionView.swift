
import SwiftUI

struct TransactionView: View {
    
    @EnvironmentObject private var transactionVM: TransactionViewModel
    @EnvironmentObject var creditCardVM: CreditCardsViewModel
    
    @State private var selectedItem: TransactionItems? = nil
    
    @State private var currentPage = 0
    @State private var inputValue: String = ""
    @State private var isIncome: Bool? = nil
    @State private var showExpenses: Bool = false
    @State private var showCreditCards: Bool = false
    @State private var showBalance: Bool = false
    @State private var showBalanceExpenses: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button {
                    isIncome = true
                    withAnimation {
                        showBalance = true
                        showExpenses = false
                        
                    }
                } label: {
                    Text("Renda")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.green.opacity(isIncome == true ? 1 : 0.2)))
                        .foregroundStyle(textColor)
                }
                Spacer()
                Button {
                    isIncome = false
                    withAnimation {
                        showExpenses = true
                        showBalance = false
                    }
                } label: {
                    Text("Despesa")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.red.opacity(isIncome == false ? 1 : 0.2)))
                        .foregroundStyle(textColor)
                }
            }
            .padding(.horizontal)
            
            if showBalance {
                TotalBalanceTransactionView()
                    .padding(.horizontal)
            }
            
            if showExpenses {
                VStack {
                    Text("Você quer usar o saldo da conta ou o Cartão de Crédito?")
                    HStack {
                        Button {
                            withAnimation {
                                showBalanceExpenses = true
                                showCreditCards = false
                            }
                        } label: {
                            Text("Saldo")
                        }
                        
                        Button {
                            withAnimation {
                                showCreditCards = true
                                showBalanceExpenses = false
                            }
                        } label: {
                            Text("Cartão")
                        }
                    }
                }
                .padding(.horizontal)
                
                
                if showBalanceExpenses {
                    VStack(spacing: 10) {
                        TotalBalanceTransactionView()
                        
                        MenuItemsTransactionView(selectedItem: $selectedItem)
                    }
                    .padding(.horizontal)
                }
                
                if showCreditCards {
                    VStack(spacing: 0) {
                        TabView(selection: $currentPage) {
                            ForEach(creditCardVM.creditCards, id: \.id) { card in
                                CardTransactionView(value: formatCurrency(card.amount), colors: [.red, .orange, .yellow])
                                    .tag(currentPage)
                            } 
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                        .frame(maxHeight: 160)
                        .animation(.easeInOut, value: currentPage)
                        
                        MenuItemsTransactionView(selectedItem: $selectedItem)
                    }
                    .padding(.horizontal)
                }
            }

            
            KeyboardTransactionView(selectedItem: $selectedItem, inputValue: $inputValue, isIncome: $isIncome)
        }
    }
}

#Preview {
    TransactionView()
        .environmentObject(TransactionViewModel())
        .environmentObject(CreditCardsViewModel())
}
