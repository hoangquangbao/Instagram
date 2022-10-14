import SwiftUI

@available(iOS 16.0, *)
struct ContentView: View {
    var body: some View {
        VStack {
            LoginView()
        }
    }
}

@available(iOS 16.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
