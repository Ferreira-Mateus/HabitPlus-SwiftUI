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
    
    private var cancellable: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    
    @Published var uiState: SignUpUIState = .none
    
    private let interactor: SignUpInteractor
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
        cancellableSignIn?.cancel()
    }
    
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
        
        let req = SignUpRequest(fullName: fullName,
                          email: email,
                          password: password,
                          document: document,
                          phone: phone,
                          birthday: birthday,
                          gender: gender.index)

        cancellable = interactor.postUser(signUpRequest: req)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { created in
                // Se criado, fazer o login primeiro
                if created {
                    let req = SignInRequest(email: self.email,
                                            password: self.password)
                    self.cancellableSignIn = self.interactor.login(signInRequest: req)
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch(completion) {
                            case .failure(let appError):
                                self.uiState = .error(appError.message)
                                break
                            case .finished:
                                break
                            }
                        } receiveValue: { success in
                            self.publisher.send(true)
                            self.uiState = .success
                        }
                }
            }

        
//        interactor.postUser(signUpRequest: req) { (successResponse, errorResponse) in
//            if let error = errorResponse {
//                DispatchQueue.main.async {
//                    self.uiState = .error(error.detail)
//                }
//            }
//            
//            if let success = successResponse {
////                WebService.login(request: SignInRequest(email: self.email,
////                                                        password: self.password)) { (successResponse, errorResponse) in
////                    if let errorSignIn = errorResponse {
////                        DispatchQueue.main.async {
////                            self.uiState = .error(errorSignIn.detail.message)
////                        }
////                    }
////                    
////                    if let successSignIn = successResponse {
////                        DispatchQueue.main.async {
////                            self.publisher.send(true)
////                            self.uiState = .success
////                        }
////                    }
////                }
//            }
//        }
    }
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
