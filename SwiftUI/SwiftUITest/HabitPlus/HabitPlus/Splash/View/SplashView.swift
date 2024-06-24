import SwiftUI

struct SplashView: View {
    
    // Instancia da viewModel, porem no observable
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        // Group apenas uma cascata que serve para agrupar e tem a função onAppear, que dispara toda vez que a tela aparecer
        Group {
            switch viewModel.uiState {
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
        }.onAppear(perform: {
            viewModel.onAppear()
        })
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

let viewModel = SplashViewModel()
let splash = SplashView(viewModel: viewModel)

#Preview {
    splash
}
