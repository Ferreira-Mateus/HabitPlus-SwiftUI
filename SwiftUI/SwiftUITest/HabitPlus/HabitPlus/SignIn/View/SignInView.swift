import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var email = ""
    @State var password = ""
    @State var navigationHidden = true
    
    @State var action: Int? = 0
    
    var body: some View {
        // Toda naveção precisa de uma classe pai, que é a navigationView, assim clicando em cadastre-se ele navega para a tela com a tag desejada
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .center, spacing: 20) {
                    
                    //Empurrar no minimo 36 de cima pra baixo
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
                        
                        numberField
                        passwordField
                        enterButton
                        registerLink
                        
                        Text("Copyright @YYY")
                            .foregroundColor(.gray)
                            .font(Font.system(size: 16).bold())
                            .padding(.top, 16)
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

extension SignInView {
    var numberField: some View {
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
            // TODO: Evento de click
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
                // Camada invisível, aqui coloco a tela de destination, aqui está um texto mas pode ser a tela interna, a tag onde vamos encontrar a tela por ela, a seleção que é o action e a label
                NavigationLink(
                    destination: Text("Tela de cadastro"),
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

