
import SwiftUI

struct MenuItemsTransactionView: View {
    
    @Binding var selectedItem: TransactionItems?
    
    var body: some View {
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
                Image(systemName: selectedItem?.iconName ?? "hand.tap")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Circle().fill(.gray))
                
                Text(selectedItem?.title ?? "Qual o motivo?")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "arrow.down")
                    .imageScale(.large)
            }
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 20).fill(.gray.opacity(0.7)))
            .frame(maxWidth: .infinity, maxHeight: 90)
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    MenuItemsTransactionView(selectedItem: .constant(.Alimentação))
}
