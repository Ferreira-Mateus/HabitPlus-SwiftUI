import SwiftUI

struct SignUpView: View {    
    
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        
        ZStack {
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .center) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Cadastro")
                            .foregroundColor(Color("textColor"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        fullNameField
                        emailField
                        passwordField
                        documentField
                        phoneField
                        birthdayField
                        genderField
                        saveButton
                    }
                    
                    Spacer()
                }.padding(.horizontal, 8)
                
            }.padding()
            if case SignUpUIState.error(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("Ok")) {
                            // TODO: Ação quando fecha o botão
                    })
                }
            }
        }
    }
}

extension SignUpView {
    var fullNameField: some View {
        EditTextView(text: $viewModel.fullName,
                     placeholder: "Nome completo*",
                     keyboard: .default,
                     error: "Nome deve ter ao menos 3 caracteres",
                     failure: viewModel.fullName.count < 3)
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "E-mail*",
                     keyboard: .emailAddress,
                     error: "E-mail inválido",
                     failure: !viewModel.email.isEmail())
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Senha*",
                     keyboard: .emailAddress,
                     error: "Senha deve ter ao menos 8 caracteres",
                     failure: viewModel.password.count < 8,
                     isSecure: true)
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(text: $viewModel.document,
                     placeholder: "CPF*",
                     keyboard: .numberPad,
                     error: "CPF inválido",
                     failure: viewModel.document.count != 11)
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(text: $viewModel.phone,
                     placeholder: "Tel",
                     keyboard: .numberPad,
                     error: "Número de telefone inválido*",
                     failure: viewModel.phone.count != 9)
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $viewModel.birthday,
                     placeholder: "Data de nascimento*",
                     keyboard: .numberPad,
                     error: "Data de nascimento inválida",
                     failure: viewModel.birthday.count < 8)
    }
}

extension SignUpView {
    var genderField: some View {
        // Pegando todos os casos do enum
        // vai identificar o id pelo seu proprio elemento (\.self)
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle()) // Estilo opcional, padrão vem com o normal
        .padding(.top, 16)
        .padding(.bottom, 32)
    }
}

extension SignUpView {
    var saveButton: some View {
        LoadingButtonView(action: {
            viewModel.signUp()
        },
                          text: "Cadastrar",
                          showProgress: self.viewModel.uiState == SignUpUIState.loading,
                          disabled: !viewModel.email.isEmail() ||
                          viewModel.password.count < 8 ||
                          viewModel.fullName.count < 3 ||
                          viewModel.document.count != 11 ||
                          viewModel.phone.count != 9 ||
                          viewModel.birthday.count < 8)
    }
}

let viewModelSignUp = SignUpViewModel()
let splashSignUp = SignUpView(viewModel: viewModelSignUp)

#Preview {
    splashSignUp
        .preferredColorScheme(.light)
}
