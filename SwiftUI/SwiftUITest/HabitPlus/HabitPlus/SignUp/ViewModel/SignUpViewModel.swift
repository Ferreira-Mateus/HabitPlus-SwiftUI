import Foundation
import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.masc
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    @Published var uiState: SignUpUIState = .none
    
    func signUp() {
        self.uiState = .loading
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        let signInRequest = SignUpRequest(fullName: fullName,
                          email: email,
                          password: password,
                          document: document,
                          phone: phone,
                          birthday: birthday,
                          gender: gender.index)

        WebService.postUser(request: signInRequest) { (successResponse, errorResponse) in
            if let error = errorResponse {
                // Main thread
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail)
                }
            }
            
            if let success = successResponse {
                DispatchQueue.main.async {
                    self.publisher.send(success)
                    if success {
                        self.uiState = .success
                    }
                }
            }
        }
    }
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
