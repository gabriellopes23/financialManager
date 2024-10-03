
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
    
    
    
    private var authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
//    var colors: [[CodableColor]] = [
//        [CodableColor(color: .purple), CodableColor(color: .indigo), CodableColor(color: .blue.opacity(0.7))],
//        [CodableColor(color: .red), CodableColor(color: .orange), CodableColor(color: .yellow)],
//        [CodableColor(color: .blue.opacity(0.5)), CodableColor(color: .blue), CodableColor(color: .blue.opacity(0.6))]
//    ]
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Balance")
                    TextField(text: $amount) {
                        Text("Limete")
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
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(
                LinearGradient(
                    colors: [.blue, .indigo, .blue.opacity(0.4)],
                    startPoint: .bottomLeading, endPoint: .topTrailing)))
            .frame(width: 300, height: 200)
            .foregroundStyle(.white)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Add New Card")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(textColor)
                }
                ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            if amount.isEmpty || numberCard.isEmpty {
                                isCardValid = true
                            } else if let userId = authService.userSession?.uid {
                                Task {
                                    try await creditCardVM.addCreditCard(amount: Double(amount) ?? 0.0, numberCard: numberCard, valid: "\(selectMonth)/\(selectYear)", typeCard: selecteTypeCard, userId: userId)
                                    
                                    amount = ""
                                    numberCard = ""
                                    dismiss()
                                }
                            }
                        } label: {
                            Text("Add")
                                .padding(10)
                                .font(.headline)
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.7)))
                                .foregroundStyle(textColor)
                        }
                }
            }
            
            if isCardValid {
                Text("Preencha os campos corretamente")
                    .foregroundStyle(.red)
                    .font(.headline)
            }
            
//            HStack {
//                Button {
//                    changeColors = [colors[0]]
//                } label: {
//                    Text("Mod 1")
//                        .padding()
//                        .foregroundStyle(textColor)
//                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.7)))
//                }
//                
//                Button {
//                    changeColors = [colors[1]]
//                } label: {
//                    Text("Mod 2")
//                        .padding()
//                        .foregroundStyle(textColor)
//                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.7)))
//                }
//                
//                Button {
//                    changeColors = [colors[2]]
//                } label: {
//                    Text("Mod 3")
//                        .padding()
//                        .foregroundStyle(textColor)
//                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.7)))
//                }
//            }
        }
    }
}

#Preview {
    CreateCreditCardView(authService: AuthService())
        .environmentObject(CreditCardsViewModel())
}
