
import SwiftUI
import Charts

struct ReportView: View {
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Text("RS1.250,00")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Chart {
                    SectorMark(
                        angle: .value("value", 5),
                        innerRadius: .ratio(0.85),
                        outerRadius: .ratio(1.05),
                        angularInset: 1)
                    .foregroundStyle(.orange)
                    .cornerRadius(20)
                    
                    SectorMark(
                        angle: .value("value", 3),
                        innerRadius: .ratio(0.85),
                        outerRadius: .ratio(1.05),
                        angularInset: 1)
                    .foregroundStyle(.red)
                    .cornerRadius(20)
                    
                    SectorMark(
                        angle: .value("value", 17),
                        innerRadius: .ratio(0.85),
                        outerRadius: .ratio(1.05),
                        angularInset: 1)
                    .foregroundStyle(.purple)
                    .cornerRadius(20)
                }
            }
            
            HStack {
                Button {
                    
                } label: {
                    Text("Day")
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("Week")
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("Month")
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("Year")
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(.gray.opacity(0.7)))
            .foregroundStyle(.text)
            .font(.title3)
            .frame(maxWidth: .infinity)
            
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
        .padding()
    }
}

#Preview {
    ReportView()
}
