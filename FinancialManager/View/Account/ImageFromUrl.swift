
import SwiftUI

struct ImageFromURL: View {
    let url: URL
    @State private var uiImage: UIImage? = nil
    @State private var isLoading: Bool = true

    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else if isLoading {
                ProgressView() // Mostra um indicador de carregamento enquanto a imagem é baixada
            } else {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
            }
        }
        .onAppear {
            loadImage(from: url)
        }
    }

    private func loadImage(from url: URL) {
        isLoading = true
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.uiImage = image
                    self.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
        task.resume()
    }
}
