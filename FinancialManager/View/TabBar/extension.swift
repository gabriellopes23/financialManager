
import SwiftUI

extension TabView {
    func customTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        
        HStack(spacing: 10) {
            Spacer()
            
            Image(systemName: imageName)
                .imageScale(.large)
                .foregroundStyle(isActive ? .white : .black)
                .frame(width: 20, height: 20)
            
            if isActive {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundStyle(isActive ? .white : .black)
            }
            Spacer()
            
        }
        .frame(maxWidth: isActive ? .infinity : 60, maxHeight: 60)
        .background(RoundedRectangle(cornerRadius: 30).fill(isActive ? principalColor : .clear))
    }
}
