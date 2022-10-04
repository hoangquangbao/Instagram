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
                Color.blue
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.7), radius: 2, y: 2)
            )
    }
}
