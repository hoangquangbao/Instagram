import SwiftUI

@available(iOS 16.0, *)
@main
struct InstagramApp: App {
    @StateObject var sessionService = SessionService()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                LoginView()
            }
            .environmentObject(sessionService)
            //            TabbarBottomView()
        }
    }
}
