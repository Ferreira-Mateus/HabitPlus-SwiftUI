import SwiftUI

struct SplashView: View {
    
    // Começando no loading pois é a splash
    @State var state: SplashUIState = .loading
    
    var body: some View {
        switch state {
        case .loading:
            loadingView(error: nil)
        case .goToSigningScreen:
            Text("Signing")
            // TODO: Navegar proxima tela
        case .goToHomeScreen:
            Text("Home")
            // TODO: Navegar proxima tela
        case .error(let error):
            loadingView(error: error)
        }
    }
}

extension SplashView {
    func loadingView(error: String?) -> some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .background(Color.white)
                .ignoresSafeArea()
            
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")) {
                            // TODO: Ação quando fecha o botão
                    })
                }
            }
        }
    }
}

#Preview {
    SplashView(state: .error("erro"))
}
