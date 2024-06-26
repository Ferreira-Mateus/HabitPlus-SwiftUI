import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var email = ""
    @State var password = ""
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
                                
                                Text("Copyright @YYY")
                                    .foregroundColor(.gray)
                                    .font(Font.system(size: 16).bold())
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
                    .background(Color.white)
                    .navigationBarTitle("Login", displayMode: .inline)
                    .navigationBarHidden(navigationHidden)
                }

            }
        }
    }
}

extension SignInView {
    var emailField: some View {
        TextField("", text: $email)
            .border(Color.black)
            .padding(.horizontal, 48)
    }
}

extension SignInView {
    var passwordField: some View {
        SecureField("", text: $password)
            .border(Color.black)
            .padding(.horizontal, 48)
    }
}

extension SignInView {
    var enterButton: some View {
        Button("Entrar") {
            viewModel.login(email: email, password: password)
        }
            .padding(.top, 24)
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

let viewModelSignIn = SignInViewModel()
let splashSignIn = SignInView(viewModel: viewModelSignIn)

#Preview {
    splashSignIn
}
