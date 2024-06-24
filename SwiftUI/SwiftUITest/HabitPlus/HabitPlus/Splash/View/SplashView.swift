import SwiftUI

struct SplashView: View {
    
    // Começando no loading pois é a splash
    @State var state: SplashUIState = .loading
    
    var body: some View {
        switch state {
        case .loading:
//            LoadingView()
            //loading
            loadingView()
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

// FORMAS DE UTILIZAR UMA VIEW
// 1. Compartilhamento | Objetos
// Reutilizar Objetos e Views
//struct LoadingView: View {
//    var body: some View {
//        ZStack {
//            Image("logo")
//                .resizable()
//                .scaledToFit()
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .padding(20)
//                .background(Color.white)
//                .ignoresSafeArea()
//        }
//    }
//}

// 2. Variáveis em extensions
//extension SplashView {
//    var loading: some View {
//        ZStack {
//            Image("logo")
//                .resizable()
//                .scaledToFit()
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .padding(20)
//                .background(Color.white)
//                .ignoresSafeArea()
//        }
//    }
//}

// 3. Funções em extensions
extension SplashView {
    func loadingView() -> some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .background(Color.white)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    //    SplashView(state: .error("AA"))
    SplashView()
}
