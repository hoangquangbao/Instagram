import SwiftUI

struct DivideView: View {
    var body: some View {
        HStack {
            VStack {
                Divider()
            }
            
            Text("OR")
                .font(.sfProTextSemibold(12, relativeTo: .title1))
                .foregroundColor(Color._000000.opacity(0.4))
            
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
