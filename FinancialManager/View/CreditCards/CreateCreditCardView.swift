
import SwiftUI

struct CreateCreditCardView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var creditCardVM: CreditCardsViewModel
    
    @State private var amount: String = ""
    @State private var numberCard: String = ""
    @State private var selectMonth: Int = 1
    @State private var selectYear: Int = 24
    @State private var selecteTypeCard: CreditCardType = .visa
    
    @State private var isCardValid: Bool = false
    
    var isEditingCard: CreditCardsModel?
    
    private var authService: AuthService
    
    init(authService: AuthService, isEditingCard: CreditCardsModel? = nil) {
        self.authService = authService
        self.isEditingCard = isEditingCard
        
        if let card = isEditingCard {
            self._amount = State(initialValue: String(card.amount))
            self._numberCard = State(initialValue: card.numberCard)
            self._selectMonth = State(initialValue: Int(card.valid.prefix(2)) ?? 1)
            self._selectYear = State(initialValue: Int(card.valid.suffix(2)) ?? 24)
            self._selecteTypeCard = State(initialValue: card.typeCard)
        }
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Balance")
                    TextField(text: $amount) {
                        Text("Limete")
                    }
                    .onAppear {
                        // Se estiver editando, preencha os valores
                        if let card = isEditingCard {
                            amount = String(card.amount)
                            numberCard = card.numberCard
                            let validDate = card.valid.split(separator: "/")
                            if validDate.count == 2 {
                                selectMonth = Int(validDate[0]) ?? 1
                                selectYear = Int(validDate[1]) ?? 24
                            }
                            selecteTypeCard = card.typeCard
                        }
                    }
                    
                    HStack {
                        Text("xxxx xxxx xxxx ")
                            .font(.footnote)
                        TextField("0000", text: $numberCard)
                            .keyboardType(.numberPad)
                    }
                    
                    HStack {
                        Text("Valid Until")
                            .font(.footnote)
                        
                        HStack(spacing: 0) {
                            Menu {
                                VStack {
                                    ForEach(1..<13) { index in
                                        Button {
                                            selectMonth = index
                                        } label: {
                                            Text(index < 10 ? "0\(index)" : "\(index)")
                                        }
                                        
                                    }
                                }
                            } label: {
                                Text(selectMonth < 10 ? "0\(selectMonth)/" : "\(selectMonth)/")
                            }
                            
                            Menu {
                                VStack {
                                    ForEach(25..<40) { index in
                                        Button {
                                            selectYear = index
                                        } label: {
                                            Text("\(index)")
                                        }
                                        
                                    }
                                }
                            } label: {
                                Text("\(selectYear)")
                            }
                            
                        }
                    }
                }
                Spacer()
                
                Menu {
                    ForEach(CreditCardType.allCases, id: \.self) { typeCard in
                        Button {
                            selecteTypeCard = typeCard
                        } label: {
                            HStack {
                                Text(typeCard.title)
                                Image(typeCard.image)
                                    .frame(width: 60, height: 30)
                            }
                        }
                        
                    }
                } label: {
                    Image(selecteTypeCard.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 30)
                }
                
            }
            .frame(width: 300, height: 170)
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(
                LinearGradient(
                    colors: [.blue, .indigo, .blue.opacity(0.4)],
                    startPoint: .bottomLeading, endPoint: .topTrailing)))
            .foregroundStyle(.white)
            
            if isCardValid {
                Text("Preencha os campos corretamente")
                    .foregroundStyle(.red)
                    .font(.headline)
            }
            
            HStack {
                Button {
                    Task {
                        if let editCard = isEditingCard {
                            try await creditCardVM.deleteCreditCard(creditCard: editCard)
                            dismiss()
                        } else {
                            dismiss()
                        }
                    }
                    
                } label: {
                    HStack {
                        Image(systemName: (isEditingCard != nil) ? "trash" : "arrow.left")
                        Text((isEditingCard != nil) ? "Delete" : "Cancel")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 10)
                    .padding()
                    .foregroundStyle(.black)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.red))
                }
                Button {
                    if amount.isEmpty || numberCard.isEmpty {
                        isCardValid = true
                    } else if let userId = authService.userSession?.uid {
                        Task {
                            if let editCard = isEditingCard {
                                var updateCard = editCard
                                updateCard.amount = Double(amount) ?? 0.0
                                updateCard.numberCard = numberCard
                                updateCard.valid = "\(selectMonth)/\(selectYear)"
                                updateCard.typeCard = selecteTypeCard
                                
                                try await creditCardVM.updateCreditCard(creditCard: updateCard)
                            } else {
                                try await creditCardVM.addCreditCard(amount: Double(amount) ?? 0.0, numberCard: numberCard, valid: "\(selectMonth)/\(selectYear)", typeCard: selecteTypeCard, userId: userId)
                            }
                            
                            amount = ""
                            numberCard = ""
                            dismiss()
                        }
                    }
                } label: {
                    Text("Add")
                        .frame(maxWidth: .infinity, maxHeight: 10)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.7)))
                        .foregroundStyle(textColor)
                }
            }
            .padding()
        }
        .navigationTitle("Add New Card")
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CreateCreditCardView(authService: AuthService())
        .environmentObject(CreditCardsViewModel())
}
