import SwiftUI
import Foundation

struct CustomTextFieldStyle: TextFieldStyle {
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color.blue, lineWidth: 1.0)
            )
    }
    
    
}
