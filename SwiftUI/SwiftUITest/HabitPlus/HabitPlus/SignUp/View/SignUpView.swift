import SwiftUI

struct SignUpView: View {
//    @ObservedObject var viewModel: SignUpViewModel
    
    @State var fullName = ""
    @State var email = ""
    @State var password = ""
    @State var document = ""
    @State var phone = ""
    @State var birthday = ""
    
    var body: some View {
        Text("cadastro")
    }
}

//let viewModelSignUp = SignUpViewModel()
//let splashSignUp = SignUpView(viewModel: viewModelSignUp)

#Preview {
    SignUpView()
}
