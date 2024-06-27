import SwiftUI

struct SignUpView: View {    
    @State var fullName = ""
    @State var email = ""
    @State var password = ""
    @State var document = ""
    @State var phone = ""
    @State var birthday = ""
    @State var gender = Gender.masc
    
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
        EditTextView(text: $fullName,
                     placeholder: "Nome completo*",
                     keyboard: .default,
                     error: "Nome deve ter ao menos 3 caracteres",
                     failure: fullName.count < 3)
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $email,
                     placeholder: "E-mail*",
                     keyboard: .emailAddress,
                     error: "E-mail inválido",
                     failure: !email.isEmail())
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(text: $password,
                     placeholder: "Senha*",
                     keyboard: .emailAddress,
                     error: "Senha deve ter ao menos 8 caracteres",
                     failure: password.count < 8,
                     isSecure: true)
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(text: $document,
                     placeholder: "CPF*",
                     keyboard: .numberPad,
                     error: "CPF inválido",
                     failure: document.count != 11)
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(text: $phone,
                     placeholder: "Tel",
                     keyboard: .numberPad,
                     error: "Número de telefone inválido*",
                     failure: phone.count != 9)
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $birthday,
                     placeholder: "Data de nascimento*",
                     keyboard: .numberPad,
                     error: "Data de nascimento inválida",
                     failure: birthday.count < 8)
    }
}

extension SignUpView {
    var genderField: some View {
        // Pegando todos os casos do enum
        // vai identificar o id pelo seu proprio elemento (\.self)
        Picker("Gender", selection: $gender) {
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
                          disabled: !email.isEmail() || 
                          password.count < 8 ||
                          fullName.count < 3 ||
                          document.count != 11 ||
                          phone.count != 9 ||
                          birthday.count < 8)
    }
}

let viewModelSignUp = SignUpViewModel()
let splashSignUp = SignUpView(viewModel: viewModelSignUp)

#Preview {
    splashSignUp
        .preferredColorScheme(.light)
}
