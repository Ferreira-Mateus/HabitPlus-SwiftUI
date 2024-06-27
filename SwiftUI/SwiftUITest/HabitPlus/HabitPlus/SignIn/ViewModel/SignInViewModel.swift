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
            print("Usuário criado! goToHome: \(value)")
            
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.uiState = .goToHomeScreen
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
