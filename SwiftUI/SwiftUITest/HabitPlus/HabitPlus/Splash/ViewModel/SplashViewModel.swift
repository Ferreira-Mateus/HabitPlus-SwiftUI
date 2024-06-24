import Foundation
import SwiftUI

// É um objeto observavel pelo body
class SplashViewModel: ObservableObject {
    
    // Published é uma variavel state publicada
    @Published var uiState: SplashUIState = .loading
    
    func onAppear() {
        // Faz algo assincrono e muda o estado da uiState
        // simulando delay:
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Aqui é chamado depois de 2 segundos
            self.uiState = .goToHomeScreen
        }
    }
    
    
}
