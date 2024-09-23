
import SwiftUI

struct HomeView: View {
    
    @State private var hideTotalBalance: Bool = false
    let totalBalance: String = "R$1.250,00"
    
    var body: some View {
        VStack(spacing: 25) {
            // seção bem vindo
            HStack(spacing: 10) {
                // Foto do usuário
                Image(systemName: "person")
                    .imageScale(.large)
                    .padding()
                    .background(Circle().fill(.gray))
                
                VStack(alignment: .leading) {
                    Text("Hi, Gabriel!")
                    HStack {
                        Text("Welcome")
                        HStack(spacing: 0) {
                            Text("Spend")
                                .fontWeight(.bold)
                            Text("Wise")
                        }
                    }
                    .font(.title3)
                }
                Spacer()
                Button {
                    // TODO: Implement this
                } label: {
                    Image(systemName: "text.alignright")
                        .font(.title)
                        .foregroundStyle(.gray)
                }
            }
            
            // Total balance
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Total Balance")
                    Text(hideTotalBalance ? String(repeating: "*", count: totalBalance.count) : totalBalance)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                Spacer()
                Button {
                    hideTotalBalance.toggle()
                } label: {
                    Image(systemName: hideTotalBalance ? "eye" : "eye.slash")
                        .imageScale(.medium)
                        .foregroundStyle(textColor)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(.gray.opacity(0.3)))
            
            // My Cards
            VStack(alignment: .leading, spacing: 5) {
                Text("My Cards")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Balance")
                                Text("R$1.250,00")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                Text("xxxx xxxx xxxx 0000")
                                    .font(.footnote)
                                Text("Valid Until 09/27")
                                    .font(.footnote)
                            }
                            Spacer()
                            Text("VISA")
                                .fontWeight(.heavy)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(
                            LinearGradient(
                                colors: [.purple, .indigo, .blue.opacity(0.7)],
                                startPoint: .bottomLeading, endPoint: .topTrailing)))
                        .frame(width: 250, height: 150)
                        .foregroundStyle(.white)
                        
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Balance")
                                Text("R$1.250,00")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                Text("xxxx xxxx xxxx 0000")
                                    .font(.footnote)
                                Text("Valid Until 09/27")
                                    .font(.footnote)
                            }
                            Spacer()
                            Text("VISA")
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(
                            LinearGradient(
                                colors: [.purple, .indigo, .blue.opacity(0.7)],
                                startPoint: .bottomLeading, endPoint: .topTrailing)))
                        .frame(width: 250, height: 150)
                        .foregroundStyle(.white)
                    }
                }
            }
            
            // relatório de atividades dirárias
            VStack(alignment: .leading, spacing: 5) {
                Text("Today's Activities")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack(spacing: 10) {
                            Image(systemName: "cup.and.saucer")
                                .padding(10)
                                .imageScale(.large)
                                .background(Circle().fill(.white.opacity(0.7)))
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.black)
                            
                            VStack(alignment: .leading) {
                                Text("Coffee")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                Text("Setember 10")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text("R$140,00")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(.principal))
                        .foregroundStyle(.white)
                        
                        HStack(spacing: 10) {
                            Image(systemName: "cup.and.saucer")
                                .padding(10)
                                .imageScale(.large)
                                .background(Circle().fill(.white.opacity(0.7)))
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.black)
                            
                            VStack(alignment: .leading) {
                                Text("Coffee")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                Text("Setember 10")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text("R$140,00")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(.principal))
                        .foregroundStyle(.white)
                        
                        HStack(spacing: 10) {
                            Image(systemName: "cup.and.saucer")
                                .padding(10)
                                .imageScale(.large)
                                .background(Circle().fill(.white.opacity(0.7)))
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.black)
                            
                            VStack(alignment: .leading) {
                                Text("Coffee")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                Text("Setember 10")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text("R$140,00")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(.principal))
                        .foregroundStyle(.white)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
