import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    var bgColor: Color = Color.blue
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.sfProTextBold(16, relativeTo: .caption1))
            .foregroundColor(.white)
            .frame(height: 45)
            .frame(maxWidth: .infinity)
            .background(
                configuration.isPressed ? bgColor.opacity(0.8) : bgColor
            )
            .cornerRadius(10)
    }
}
