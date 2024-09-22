
import SwiftUI

struct TextFieldLoginAndSignup: View {
    
    var imageName: String
    var titleTextField: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .imageScale(.large)
            TextField(titleTextField, text: $text)
                .foregroundStyle(.white)
                .autocapitalization(.none)
                .textInputAutocapitalization(.never)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(principalColor))
        .padding(.horizontal)
    }
}

struct SecureFieldLoginAndSignup: View {
    
    var imageName: String
    var titleTextField: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .imageScale(.large)
            SecureField(titleTextField, text: $text)
                .foregroundStyle(.white)
                .autocapitalization(.none)
                .textInputAutocapitalization(.never)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(principalColor))
        .padding(.horizontal)
    }
}
