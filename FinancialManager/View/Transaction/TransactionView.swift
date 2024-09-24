
import SwiftUI

struct TransactionView: View {
    @State private var currentPage = 0
    
    let cards = [
        CardTransactionView(),
        CardTransactionView(),
        CardTransactionView()
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
            
            HStack(spacing: 10) {
                Image(systemName: "bag")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Circle().fill(.gray))
                
                Text("Super Mercado")
                    .font(.title3)
                    .fontWeight(.bold)
                    Spacer()
                Image(systemName: "arrow.down")
                    .imageScale(.large)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(.gray.opacity(0.7)))
            .frame(maxWidth: .infinity, maxHeight: 90)
            
            ScrollView {
                
            }
        }
        .padding()
    }
}

#Preview {
    TransactionView()
}
