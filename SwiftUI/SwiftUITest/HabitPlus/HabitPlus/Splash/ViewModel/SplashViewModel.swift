import Foundation
import SwiftUI

// É um objeto observavel pelo body
// Camada de regra de negocio
// Exibição dos dados, camada de ação
// Classe observada pela view, que enxerga um view model
// A view observa todos os estados de referencia na viewModel
// Sempre que muda algum estado, a viewModel notifica a View
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
