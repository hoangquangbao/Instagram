import SwiftUI

struct CustomPhoneTextFieldStyle: TextFieldStyle {
        
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.sfProTextMedium(16, relativeTo: .caption2))
            .foregroundColor(Color.black)
            .frame(maxWidth: .infinity)
            .background {
                Color.white
            }
            .keyboardType(.numberPad)
    }
}
