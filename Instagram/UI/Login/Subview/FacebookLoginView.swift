import SwiftUI

struct FacebookLoginView: View {
    
    private var title: String = "Log in with Facebook"
    
    var body: some View {
        Button {
            print("Not implemented yet!")
        } label: {
            HStack(alignment: .center) {
                Image.icnFacebook
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text(title)
                    .font(.sfProTextSemibold(14, relativeTo: .caption1))
                    .foregroundColor(Color.blue)
            }
        }
    }
}

struct FacebookLoginView_Previews: PreviewProvider {
    static var previews: some View {
        FacebookLoginView()
    }
}
