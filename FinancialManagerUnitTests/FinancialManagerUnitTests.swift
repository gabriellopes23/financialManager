
import XCTest
@testable import FinancialManager

class testar_quando_for_fazer_login: XCTestCase {

    func test_email_e_senha_valido() {
        
        let registrationVM = RegistrationViewModel()
        
        let email = "test@gmail.com"
        let password = "Teste#20"
        
        let registration = registrationVM.validateEmailAndPassword(email: email, password: password)
        
        XCTAssertEqual(registration.0, true)
        print(registration.1)
        
    }

}
