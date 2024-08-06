import Foundation
import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUIState = .loading
    
    private var cancellable: AnyCancellable?
    
    private let interactor: SplashInteractor
        
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func onAppear() {
        // Se userAuth == null -> tela de login
        // userAuth != null && expirou -> Refresh
        // senão -> tela de home
        cancellable = interactor.fetchAuth()
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                } else if Date().timeIntervalSince1970 > Date().timeIntervalSince1970 + Double(userAuth!.expires) {
                    
                } else {
                    self.uiState = .goToHomeScreen
                }
            }
    }
}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
}
