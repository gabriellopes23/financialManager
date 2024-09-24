
import SwiftUI

func transactionItem(imageName: String, title: String) -> some View {
    HStack {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
        
        Text(title)
            .font(.system(size: 14))
    }
}
