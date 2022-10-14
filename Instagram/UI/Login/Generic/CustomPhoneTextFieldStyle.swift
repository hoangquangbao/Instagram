import SwiftUI

struct CustomPhoneTextFieldStyle: TextFieldStyle {
        
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.sfProTextRegular(15, relativeTo: .caption1))
            .foregroundColor(Color.black)
            .frame(maxWidth: .infinity)
            .background {
                Color.white
            }
            .keyboardType(.numberPad)
    }
}
