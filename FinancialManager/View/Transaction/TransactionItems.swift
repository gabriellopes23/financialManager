
import Foundation

enum TransactionItems: CaseIterable {
    case Aluguel_hipoteca
    case Alimentação
    case Contas_de_energia
    case Internet_TV
    case Telefone
    case Transporte
    case Saúde_e_seguros
    case Educação
    case Vestuário
    case Lazer_e_entretenimento
    case Viagens_e_férias
    case Cuidados_pessoais
    case Tecnologia
    case Crédito_e_dívidas
    case Produtos_de_assinatura
    case Hobbies
    case Aplicativos_e_jogos
    case Doações_e_caridade
    case Serviços_de_delivery
    
    var title: String {
        switch self {
        case .Aluguel_hipoteca:
            return "Aluguel/Hipoteca"
        case .Alimentação:
            return "Alimentação"
        case .Contas_de_energia:
            return "Energia"
        case .Internet_TV:
            return "Internet/TV"
        case .Telefone:
            return "Telefone"
        case .Transporte:
            return "Transporte"
        case .Saúde_e_seguros:
            return "Saúde/Seguros"
        case .Educação:
            return "Educação"
        case .Vestuário:
            return "Vestuário"
        case .Lazer_e_entretenimento:
            return "Lazer/Entreterimento"
        case .Viagens_e_férias:
            return "Viagens/Férias"
        case .Cuidados_pessoais:
            return "Cuidados Pessoais"
        case .Tecnologia:
            return "Tecnologia"
        case .Crédito_e_dívidas:
            return "Crédito/Dívidas"
        case .Produtos_de_assinatura:
            return "Assinaturas"
        case .Hobbies:
            return "Hobbies"
        case .Aplicativos_e_jogos:
            return "Apps/Jogos"
        case .Doações_e_caridade:
            return "Doação/Caridade"
        case .Serviços_de_delivery:
            return "Delivery"
        }
    }
    
    var iconName: String {
        switch self {
        case .Aluguel_hipoteca:
            return "house"
        case .Alimentação:
            return "fork.knife"
        case .Contas_de_energia:
            return "bolt"
        case .Internet_TV:
            return "network"
        case .Telefone:
            return "phone"
        case .Transporte:
            return "car"
        case .Saúde_e_seguros:
            return "heart"
        case .Educação:
            return "studentdesk"
        case .Vestuário:
            return "tshirt"
        case .Lazer_e_entretenimento:
            return "figure.mind.and.body"
        case .Viagens_e_férias:
            return "airplane.departure"
        case .Cuidados_pessoais:
            return "person"
        case .Tecnologia:
            return "laptopcomputer"
        case .Crédito_e_dívidas:
            return "creditcard"
        case .Produtos_de_assinatura:
            return "rectangle.and.pencil.and.ellipsis"
        case .Hobbies:
            return "figure.gymnastics"
        case .Aplicativos_e_jogos:
            return "formfitting.gamecontroller"
        case .Doações_e_caridade:
            return "dollarsign.bank.building"
        case .Serviços_de_delivery:
            return "motorcycle"
        }
    }
}
