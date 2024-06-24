import SwiftUI

struct SplashView: View {
    
    // Começando no loading pois é a splash
    @State var state: SplashUIState = .loading
    
    var body: some View {
        switch state {
        case .loading:
            Text("Loading")
        case .goToSigningScreen:
            Text("Signing")
            // TODO: Navegar proxima tela
        case .goToHomeScreen:
            Text("Home")
            // TODO: Navegar proxima tela
        case .error(let msg):
            Text("Erro \(msg)")
        }
    }
}

#Preview {
    //    SplashView(state: .error("AA"))
    SplashView()
}
