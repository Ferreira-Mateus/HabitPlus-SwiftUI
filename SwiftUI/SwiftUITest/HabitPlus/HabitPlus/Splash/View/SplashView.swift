import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group {
            switch viewModel.uiState {
            case .loading:
                loadingView(error: nil)
            case .goToSignInScreen:
                viewModel.signInView()
            case .goToHomeScreen:
                viewModel.homeView()
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

let viewModel = SplashViewModel(interactor: SplashInteractor())
let splash = SplashView(viewModel: viewModel)

#Preview {
    splash.preferredColorScheme(.light)
}
