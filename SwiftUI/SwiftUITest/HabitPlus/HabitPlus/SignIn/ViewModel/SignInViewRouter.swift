import Foundation
import SwiftUI

// Router que retorna a tela criada da nova viewModel, para servir de meio termo entre a model passada e a nova
enum SignInViewRouter {
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    
    static func makeSignUpView() -> some View {
//        let viewModel = SignUpViewModel()
        return SignUpView()
    }
}
