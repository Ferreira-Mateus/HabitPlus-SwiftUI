import Foundation
import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    
    private let publisher = PassthroughSubject<Bool, Never>()
    private let interactor: SignInInteractor
    
    @Published var uiState: SignInUIState = .none
    
    init(interactor: SignInInteractor) {
        self.interactor = interactor
        cancellable = publisher.sink(receiveValue: { value in
            
            if value {
                self.uiState = .goToHomeScreen
            }
        })
    }
    
    deinit {
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }

    func login() {
        self.uiState = .loading
        
        let req = SignInRequest(email: email,
                                password: password)
        
        // Vai ser disparado toda vez que o interactor trocar o future
        cancellableRequest = interactor.login(loginRequest: req)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // Aqui acontece o Error ou Finished
                switch(completion) {
                    case .failure(let appError):
                    self.uiState = SignInUIState.error(appError.message) 
                    break
                    case .finished:
                    break
                }
            } receiveValue: { success in
                let userAuth = UserAuth(idToken: success.accessToken,
                                        refreshToken: success.refreshToken,
                                        expires: Date().timeIntervalSince1970 + Double(success.expires),
                                        tokenType: success.tokenType)
                self.interactor.insertAuth(userAuth: userAuth)
                self.uiState = .goToHomeScreen
            }

        
//        interactor.login(loginRequest: req) { (successResponse, errorResponse) in
//            if let error = errorResponse {
//                DispatchQueue.main.async {
//                    self.uiState = .error(error.detail.message)
//                }
//            }
//            
//            if let success = successResponse {
//                DispatchQueue.main.async {
//                    self.uiState = .goToHomeScreen
//                }
//            }
//        }
    }
}

extension SignInViewModel {
    func goToHomeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    
    func goToSignUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}
