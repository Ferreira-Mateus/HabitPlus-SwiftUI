import SwiftUI

struct EditTextView: View {
    
    @Binding var text: String
    var placeholder: String = ""
    var keyboard: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? = nil
    var isSecure: Bool = false
    
    var body: some View {
        
        VStack {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
                // Passando o TextFieldStyle customizado para esse, para manter o padrão
            }
            
            if let error = error, failure == true, !text.isEmpty {
                Text(error).foregroundColor(.red)
            } else {
                
            }
            
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    VStack {
        EditTextView(text: .constant(""), 
                     placeholder: "Email")
            .padding()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .previewDevice("iPhone 11")
    .preferredColorScheme(.dark)
}

#Preview {
    VStack {
        EditTextView(text: .constant(""), 
                     placeholder: "Email")
            .padding()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .previewDevice("iPhone 11")
    .preferredColorScheme(.light)
}
