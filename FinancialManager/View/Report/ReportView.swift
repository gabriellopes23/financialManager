
import SwiftUI
import Charts

struct ReportView: View {
    
    @EnvironmentObject var transactionVM: TransactionViewModel
    @EnvironmentObject var creditCardVM: CreditCardsViewModel
    @State private var selectedPeriod: TimePeriod = .month
    @State private var isSelected: Int = 2
    @State private var currentPage: Int = 0
    
    var filteredTransaction: [TransactionModel] {
        filterTransaction(for: selectedPeriod)
    }
    
    var totalIncome: Double {
        filteredTransaction
            .filter { $0.fromAccount == .account && $0.type == .income }
            .reduce(0) { $0 + $1.amount }
    }
    
    var totalExpense: Double {
        filteredTransaction
            .filter { $0.fromAccount == .account && $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
    }
    
    var totalExpenseCreditCard: Double {
        filteredTransaction
            .filter { $0.fromAccount == .creditCard && $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
    }
    
    var totalExpenses: Double {
        totalExpense + totalExpenseCreditCard
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            TabView(selection: $currentPage) {
                ZStack {
                    VStack {
                        Text("Total Expense")
                        Text(formatCurrency(totalExpenses))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
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
                    selectedPeriod = .day
                    isSelected = 0
                } label: {
                    Text("Day")
                        .foregroundStyle(isSelected == 0 ? .black : .black.opacity(0.3))
                        .fontWeight(isSelected == 0 ? .bold : .regular)
                }
                Spacer()
                Button {
                    selectedPeriod = .week
                    isSelected = 1
                } label: {
                    Text("Week")
                        .foregroundStyle(isSelected == 1 ? .black : .black.opacity(0.3))
                        .fontWeight(isSelected == 1 ? .bold : .regular)
                }
                Spacer()
                Button {
                    selectedPeriod = .month
                    isSelected = 2
                } label: {
                    Text("Month")
                        .foregroundStyle(isSelected == 2 ? .black : .black.opacity(0.3))
                        .fontWeight(isSelected == 2 ? .bold : .regular)
                }
                Spacer()
                Button {
                    selectedPeriod = .year
                    isSelected = 3
                } label: {
                    Text("Year")
                        .foregroundStyle(isSelected == 3 ? .black : .black.opacity(0.3))
                        .fontWeight(isSelected == 3 ? .bold : .regular)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(.gray.opacity(0.7)))
            .foregroundStyle(.text)
            .font(.title3)
            .frame(maxWidth: .infinity)
            
            if filteredTransaction.isEmpty {
                ContentUnavailableView("Nenhuma atividades registrada", systemImage: "pencil.and.list.clipboard")
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(filteredTransaction, id: \.id) { transaction in
                        ActivitiesView(iconName: transaction.iconName, title: transaction.title, date: formatDate(transaction.date), amount: formatCurrency(transaction.amount))
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    func filterTransaction(for period: TimePeriod) -> [TransactionModel] {
        let calendar = Calendar.current
        let now = Date()
        
        return transactionVM.transactions.filter { transaction in
            switch period {
            case .day:
                // Verificar se a transação aconteceu no mesmo dia
                return calendar.isDate(transaction.date, inSameDayAs: now)
                
            case .week:
                // Verificar se a transação aconteceu na mesma semana
                guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: now)?.start else { return false }
                let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek) ?? now
                return transaction.date >= startOfWeek && transaction.date < endOfWeek
                
            case .month:
                // Verificar se a transação aconteceu no mesmo mês
                guard let startOfMonth = calendar.dateInterval(of: .month, for: now)?.start else { return false }
                let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth) ?? now
                return transaction.date >= startOfMonth && transaction.date < endOfMonth
                
            case .year:
                // Verificar se a transação aconteceu no mesmo ano
                guard let startOfYear = calendar.dateInterval(of: .year, for: now)?.start else { return false }
                let endOfYear = calendar.date(byAdding: .year, value: 1, to: startOfYear) ?? now
                return transaction.date >= startOfYear && transaction.date < endOfYear
            }
        }
    }
}

#Preview {
    ReportView()
        .environmentObject(TransactionViewModel())
        .environmentObject(CreditCardsViewModel())
}
