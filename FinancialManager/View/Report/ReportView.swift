
import SwiftUI
import Charts

struct ReportView: View {
    
    @EnvironmentObject var transactionVM: TransactionViewModel
    @EnvironmentObject var creditCardVM: CreditCardsViewModel
    
    @State private var currentPage: Int = 0
    
    var totalIncome: Double {
        transactionVM.transactions
            .filter { $0.fromAccount == .account && $0.type == .income }
            .reduce(0) { $0 + $1.amount }
    }
    
    var totalExpense: Double {
        transactionVM.transactions
            .filter { $0.fromAccount == .account && $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
    }
    
    var totalExpenseCreditCard: Double {
        transactionVM.transactions
            .filter { $0.fromAccount == .creditCard && $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        VStack(spacing: 20) {
                
                TabView(selection: $currentPage) {
                    ZStack {
                        Text(formatCurrency(transactionVM.totalBalance))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Chart {
                            SectorMark(
                                angle: .value("Credit Card", totalExpenseCreditCard),
                                innerRadius: .ratio(0.85),
                                outerRadius: .ratio(1.05),
                                angularInset: 1)
                            .foregroundStyle(.orange)
                            .cornerRadius(20)
                            
                            SectorMark(
                                angle: .value("Despesa", totalExpense),
                                innerRadius: .ratio(0.85),
                                outerRadius: .ratio(1.05),
                                angularInset: 1)
                            .foregroundStyle(.red)
                            .cornerRadius(20)
                            
                            SectorMark(
                                angle: .value("Receita", totalIncome),
                                innerRadius: .ratio(0.85),
                                outerRadius: .ratio(1.05),
                                angularInset: 1)
                            .foregroundStyle(.green)
                            .cornerRadius(20)
                        }
                    }
                    .tag(0)
//                    
                    VStack {
                        CharsInformationView(color: .green, title: "Receita", amount: formatCurrency(totalIncome))
                        CharsInformationView(color: .red, title: "Despesas", amount: formatCurrency(totalExpense))
                        CharsInformationView(color: .orange, title: "Cartão de Crédito", amount: formatCurrency(totalExpenseCreditCard))
                    }
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle())
            
            HStack {
                Button {
                    
                } label: {
                    Text("Day")
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("Week")
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("Month")
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("Year")
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(.gray.opacity(0.7)))
            .foregroundStyle(.text)
            .font(.title3)
            .frame(maxWidth: .infinity)
            
            if transactionVM.transactions.isEmpty {
                ContentUnavailableView("Nenhuma atividades registrada", systemImage: "pencil.and.list.clipboard")
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(transactionVM.transactions, id: \.id) { transaction in
                        ActivitiesView(iconName: transaction.iconName, title: transaction.title, date: formatDate(transaction.date), amount: formatCurrency(transaction.amount))
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ReportView()
        .environmentObject(TransactionViewModel())
        .environmentObject(CreditCardsViewModel())
}
