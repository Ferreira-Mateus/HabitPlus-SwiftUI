import Foundation
import SwiftUI

// Router que retorna a tela criada da nova viewModel, para servir de meio termo entre a model passada e a nova
enum SplashViewRouter {
    static func makeSignInView() -> some View {
        let viewModel = SignInViewModel()
        return SignInView(viewModel: viewModel)
    }
}
