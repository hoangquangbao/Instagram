import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.sfProTextBold(16, relativeTo: .title1))
            .foregroundColor(.white)
            .frame(height: 45)
            .frame(maxWidth: .infinity)
            .background(
                configuration.isPressed ? Color.blue.opacity(0.8) : Color.blue
            )
            .cornerRadius(10)
    }
}
