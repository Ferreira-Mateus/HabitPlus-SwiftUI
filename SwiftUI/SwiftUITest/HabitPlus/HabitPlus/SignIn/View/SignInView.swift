import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var navigationHidden = true
    
    @State var action: Int? = 0
    
    var body: some View {
        
        ZStack {
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.goToHomeView()
                
            } else {
                NavigationView {
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            Spacer(minLength: 36)
                            
                            VStack(alignment: .center, spacing: 8) {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 96)
                                
                                Text("Login")
                                    .foregroundColor(.blue)
                                    .font(Font.system(.title).bold())
                                    .padding(.bottom, 8)
                                
                                emailField
                                passwordField
                                enterButton
                                registerLink
                                
                                Text("Copyright - MFA LTDA 2022")
                                    .foregroundColor(.gray)
                                    .font(Font.system(size: 13).bold())
                                    .padding(.top, 16)
                            }
                        }
                        if case SignInUIState.error(let value) = viewModel.uiState {
                            Text("")
                                .alert(isPresented: .constant(true)) {
                                    Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("Ok")) {
                                        // TODO: Ação quando fecha o botão
                                })
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 32)
                    .navigationBarTitle("Login", displayMode: .inline)
                    .navigationBarHidden(navigationHidden)
                }
                .onAppear {
                    self.navigationHidden = true
                }
                .onDisappear {
                    self.navigationHidden = false
                }

            }
        }
    }
}

extension SignInView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "E-mail",
                     keyboard: .emailAddress,
                     error: "E-mail inválido",
                     failure: !viewModel.email.isEmail())
    }
}

extension SignInView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Senha",
                     keyboard: .emailAddress,
                     error: "Senha deve ter ao menos 8 caracteres",
                     failure: viewModel.password.count < 8,
                     isSecure: true)
    }
}

extension SignInView {
    var enterButton: some View {
        LoadingButtonView(action: {
            viewModel.login()
        },
                          text: "Entrar",
                          showProgress: self.viewModel.uiState == SignInUIState.loading, disabled: false)
    }
}

extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Ainda não possií login ativo?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            
            ZStack {
                NavigationLink(
                    destination: viewModel.goToSignUpView(),
                    tag: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/,
                    selection: $action,
                    label: { EmptyView() })
                
                Button("Cadastre-se") {
                    self.action = 1
                }
            }
        }
    }
}

let viewModelSignIn = SignInViewModel(interactor: SignInInteractor())
let splashSignIn = SignInView(viewModel: viewModelSignIn)

#Preview {
    splashSignIn
        .preferredColorScheme(.light)
}
