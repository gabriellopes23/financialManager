
import SwiftUI

struct KeyboardTransactionView: View {
    
    @Binding var inputValue: String
    
    let keys: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", "⌫"],
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Spacer()
            HStack(alignment: .bottom) {
                Text(inputValue)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button {
                    
                } label: {
                    Text("Enviar")
                        .padding()
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(width: 110, height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.red))
                }

            }
            .padding(.horizontal)
            
            VStack {
                ForEach(keys, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { key in
                            Button {
                                keyPress(key: key)
                            } label: {
                                Text(key)
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(textColor)
                            }

                        }
                    }

                }
            }
        }
    }
    
    func keyPress(key: String) {
        switch key {
        case "⌫":
            if !inputValue.isEmpty {
                inputValue.removeLast()
            }
        default:
            inputValue += key
        }
    }
}

#Preview {
    KeyboardTransactionView(inputValue: .constant("86"))
}
