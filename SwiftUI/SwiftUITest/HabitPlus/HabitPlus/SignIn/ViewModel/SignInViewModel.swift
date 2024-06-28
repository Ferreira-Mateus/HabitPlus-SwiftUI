import Foundation
import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    @State var email = ""
    @State var password = ""

    private var cancellable: AnyCancellable?
    private let publisher = PassthroughSubject<Bool, Never>()
    
    @Published var uiState: SignInUIState = .none
    
    init() {
        cancellable = publisher.sink(receiveValue: { value in
            
            if value {
                self.uiState = .goToHomeScreen
            }
        })
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func login() {
        self.uiState = .loading
        
        let req = SignInRequest(email: email,
                                password: password)
        WebService.login(request: req) { (successResponse, errorResponse) in
            if let error = errorResponse {
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail)
                }
            }
            
            if let success = successResponse {
                DispatchQueue.main.async {
                    self.uiState = .goToHomeScreen
                }
            }
        }
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
