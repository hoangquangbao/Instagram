import SwiftUI

struct DivideView: View {
    var body: some View {
        HStack {
            VStack {
                Divider()
            }
            
            Text("OR")
                .font(.sfProTextSemibold(12, relativeTo: .caption1))
                .foregroundColor(Color.black.opacity(0.5))
            
            VStack {
                Divider()
            }
        }
    }
}

struct DivideView_Previews: PreviewProvider {
    static var previews: some View {
        DivideView()
    }
}
