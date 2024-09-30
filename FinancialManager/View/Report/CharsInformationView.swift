
import SwiftUI

struct CharsInformationView: View {
    
    let color: Color
    let title: String
    let amount: String
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10).fill(color)
                .frame(width: 30, height: 30)
            Spacer()
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
            Spacer()
            Text(amount)
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
}
