import SwiftUI

@available(iOS 16.0, *)
@main
struct InstagramApp: App {
    @StateObject var sessionService = SessionService()
    @StateObject var vm = LoginViewModel()
    @StateObject var perform = BackLoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if isLoggedIn() {
                    TabbarBottomView()
                } else {
                    LoginView()
                }
            }
            .environmentObject(sessionService)
            .environmentObject(vm)
            .environmentObject(perform)
            //            TabbarBottomView()
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
}
