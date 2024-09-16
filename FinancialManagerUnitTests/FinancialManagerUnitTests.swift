
import XCTest
@testable import FinancialManager

class testar_quando_for_fazer_login: XCTestCase {

    func test_criar_usuario_com_sucesso() {
        
        let registrationVM = RegistrationViewModel()
        
        let name = "Gabriel"
        let email = "test@gmail.com"
        let password = "Teste#20"
        let repeatPassword = "Teste#20"
        
        let registration = registrationVM.createUser(name: name, email: email, password: password, repeatPassword: repeatPassword)
        
        // testando se o email e a senha são válidos
        XCTAssertEqual(registration.0, true)
        print(registration.1)
    }

}
