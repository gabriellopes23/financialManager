
import XCTest
import FirebaseAuth
@testable import FinancialManager

class testar_quando_for_fazer_login: XCTestCase {

    func test_criar_usuario_com_sucesso() async {
        
        let registrationVM = await AuthenticationViewModel(authService: AuthService())
        
        let name = "Gabriel"
        let email = "test@gmail.com"
        let password = "Teste#20"
        let repeatPassword = "Teste#20"
        
        let registration = await registrationVM.registrationUser(name: name, email: email, password: password, repeatPassword: repeatPassword)
        
        XCTAssertEqual(registration.0, true)
    }

    func test_error_ao_criar_um_novo_usuario() async {
        
        let registrationVM = await AuthenticationViewModel(authService: AuthService())
        
        let name = "Gabriel"
        let email = "test@gmail.com"
        let password = "Teste#20"
        let repeatPassword = "Teste20"
        
        let registration = await registrationVM.registrationUser(name: name, email: email, password: password, repeatPassword: repeatPassword)
        
        XCTAssertEqual(registration.0, false)
        print(registration.1)
    }
}
