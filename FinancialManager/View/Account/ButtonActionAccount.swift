
import SwiftUI

struct ButtonActionAccount: View {
    
    let title: String
    let imageName: String
    let color: Color
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 10) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .padding()
                    .background(Circle().fill(color))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                
                Text(title)
                    .font(.title2)
                
                Spacer()
                
                Image(systemName: "arrowtriangle.right.fill")
                    .imageScale(.small)
            }
            .foregroundStyle(textColor)
            .padding(.horizontal)
        }

    }
}

//#Preview {
//    ButtonActionAccount(title: "Change Name", imageName: "pencil", color: .green)
//}
