
import SwiftUI

struct TransactionView: View {
    @State private var currentPage = 0
    @State private var inputValue: String = "R$0,00"
    @State private var selectedItem: TransactionItems = .Alimentação
    
    let cards = [
        CardTransactionView(value: "R$1.250,00", colors: [.indigo, .blue, .blue.opacity(0.7)]),
        CardTransactionView(value: "R$899,80", colors: [.red, .orange, .yellow]),
        CardTransactionView(value: "R$2.57,09", colors: [.purple, .blue.opacity(0.7), .blue])
    ]
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                TabView(selection: $currentPage) {
                    ForEach(cards.indices, id: \.self) { card in
                        cards[card]
                            .tag(card)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 180)
                .animation(.easeInOut, value: currentPage)
            }
            .padding(.horizontal)
            
            Menu {
                VStack {
                    ForEach((TransactionItems.allCases), id: \.self) { item in
                        Button {
                            selectedItem = item
                        } label: {
                            transactionItem(imageName: item.iconName, title: item.title)
                        }

                    }
                }
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: selectedItem.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 35)
                        .padding()
                        .background(Circle().fill(.gray))
                    
                    Text(selectedItem.title)
                        .font(.title3)
                        .fontWeight(.bold)
                        Spacer()
                    Image(systemName: "arrow.down")
                        .imageScale(.large)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(.gray.opacity(0.7)))
                .frame(maxWidth: .infinity, maxHeight: 90)
                .padding(.horizontal)
                .foregroundStyle(.black)
            }

            
            
            KeyboardTransactionView(inputValue: $inputValue)
        }
    }
}

#Preview {
    TransactionView()
}
