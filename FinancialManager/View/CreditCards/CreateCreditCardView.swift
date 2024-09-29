
import SwiftUI

struct CreateCreditCardView: View {
    
    @EnvironmentObject var creditCardVM: CreditCardsViewModel
    
    @State private var amount: String = ""
    @State private var numberCard: String = ""
    @State private var selectMonth: Int = 1
    @State private var selectYear: Int = 24
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 20) {
                Text("Balance")
                TextField(text: $amount) {
                    Text("Limete")
                }
                
                TextField(text: $numberCard) {
                    Text("xxxx xxxx xxxx 0000")
                        .font(.footnote)
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
                
            } label: {
                Text("VISA")
                    .fontWeight(.heavy)
            }

        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(
            LinearGradient(
                colors: [.purple, .indigo, .blue.opacity(0.7)],
                startPoint: .bottomLeading, endPoint: .topTrailing)))
        .frame(width: 300, height: 200)
        .foregroundStyle(.white)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Add New Card")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(textColor)
            }
            ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        creditCardVM.addCreditCard(amount: Double(amount) ?? 0.0, numberCard: numberCard, valid: "\(selectMonth)/\(selectYear)", type: .visa)
                    } label: {
                        Text("Add")
                            .padding(10)
                            .font(.title3)
                            .background(RoundedRectangle(cornerRadius: 10).fill(principalColor))
                            .foregroundStyle(textColor)
                    }
            }
        }
    }
}

#Preview {
    CreateCreditCardView()
        .environmentObject(CreditCardsViewModel())
}
