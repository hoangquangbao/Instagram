import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.sfProTextRegular(15, relativeTo: .caption1))
            .foregroundColor(Color.black)
            .padding(.leading)
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .overlay {
                RoundedRectangle(cornerRadius: 5).stroke(Color.black.opacity(0.5), lineWidth: 0.5)
            }
            .background {
                Color.white
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .submitLabel(.done)
    }
}
