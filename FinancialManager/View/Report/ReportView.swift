
import SwiftUI
import Charts

struct ReportView: View {
    
    @EnvironmentObject var transactionVM: TransactionViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Text(formatCurrency(transactionVM.totalBalance))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Chart {
                    SectorMark(
                        angle: .value("Receita", 5),
                        innerRadius: .ratio(0.85),
                        outerRadius: .ratio(1.05),
                        angularInset: 1)
                    .foregroundStyle(.orange)
                    .cornerRadius(20)
                    
                    SectorMark(
                        angle: .value("value", 3),
                        innerRadius: .ratio(0.85),
                        outerRadius: .ratio(1.05),
                        angularInset: 1)
                    .foregroundStyle(.red)
                    .cornerRadius(20)
                    
                    SectorMark(
                        angle: .value("value", 17),
                        innerRadius: .ratio(0.85),
                        outerRadius: .ratio(1.05),
                        angularInset: 1)
                    .foregroundStyle(.purple)
                    .cornerRadius(20)
                }
            }
            
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
    }
}

#Preview {
    ReportView()
        .environmentObject(TransactionViewModel())
}
