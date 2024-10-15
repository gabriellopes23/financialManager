
import SwiftUI
import SwiftData

struct HomeView: View {
    
    @EnvironmentObject var transactionVM: TransactionViewModel
    @State private var hideTotalBalance: Bool = false
    @State private var showCreateCard: Bool = false
    @State private var userName: String = ""
    @State private var profileImage: UIImage?
    @State private var downloadURL: URL?
    @State private var isEditingCard: CreditCardsModel? = nil
    @State private var deleteActivity: Bool = false
    
    @EnvironmentObject var creditCardVM: CreditCardsViewModel
    @EnvironmentObject var authService: AuthService
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                // seção bem vindo
                HStack(spacing: 10) {
                    // Foto do usuário
                    
                    if let imageUrl = authService.profileImageUrl {
                        ImageFromURL(url: imageUrl) // Carregar a imagem localmente
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding()
                            .background(Circle().fill(.gray.opacity(0.6)))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Hi, \(authService.userName)!")
                        HStack {
                            Text("Welcome")
                            HStack(spacing: 0) {
                                Text("Spend")
                                    .fontWeight(.bold)
                                Text("Wise")
                            }
                        }
                        .font(.title3)
                    }
                    Spacer()
                    Button {
                        // TODO: Implement this
                    } label: {
                        Image(systemName: "text.alignright")
                            .font(.title)
                            .foregroundStyle(.gray)
                    }
                }
                
                // Total balance
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Total Balance")
                        Text(hideTotalBalance ? String(repeating: "*", count: formatCurrency(transactionVM.totalBalance).count) : formatCurrency(transactionVM.totalBalance))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    Button {
                        hideTotalBalance.toggle()
                    } label: {
                        Image(systemName: hideTotalBalance ? "eye" : "eye.slash")
                            .imageScale(.medium)
                            .foregroundStyle(textColor)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(.gray.opacity(0.3)))
                
                // My Cards
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("My Cards")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                        Button {
                            withAnimation {
                                showCreateCard = true
                            }
                        } label: {
                            HStack {
                                Text("Add")
                                Image(systemName: "plus")
                                    .foregroundStyle(textColor)
                            }
                        }
                        
                    }
                    
                    if creditCardVM.creditCards.isEmpty {
                        ContentUnavailableView("Nenhum Cartão cadastrado", systemImage: "creditcard")
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(creditCardVM.creditCards, id: \.id) { card in
                                    CreditCardsView(amount: formatCurrency(card.amount), numberCard: card.numberCard, valid: card.valid, type: card.typeCard)
                                        .onTapGesture {
                                            showCreateCard = true
                                            isEditingCard = card
                                        }
                                }
                            }
                        }
                    }
                }
                
                // relatório de atividades dirárias
                VStack(alignment: .leading, spacing: 5) {
                    Text("Today's Activities")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    if transactionVM.transactions.filter({ Calendar.current.isDateInToday($0.date) }).isEmpty {
                        ContentUnavailableView("Nenhuma atividades registrada", systemImage: "pencil.and.list.clipboard")
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(transactionVM.transactions, id: \.id) { transaction in
                                ActivitiesView(iconName: transaction.iconName, title: transaction.title, date: formatDate(transaction.date), amount: formatCurrency(transaction.amount), deleteActivity: $deleteActivity, deleteTransaction: transaction)
                                    .onTapGesture {
                                        withAnimation {
                                            deleteActivity.toggle()
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $showCreateCard, destination: {
                CreateCreditCardView(authService: authService, isEditingCard: isEditingCard)
            })
            .onAppear {
                Task {
                    guard let userId = authService.userSession?.uid else { return }
                    
                    try await creditCardVM.fetchUserCreditCards(userId: userId)
                    try await transactionVM.fetchTransaction(userId: userId)
                }
            }
            .padding()
        }
    }
    
}

#Preview {
    HomeView()
        .environmentObject(TransactionViewModel(creditCard: CreditCardsViewModel()))
        .environmentObject(CreditCardsViewModel())
        .environmentObject(AuthService())
}
