import SwiftUI

@main
struct InstagramApp: App {
    
    @StateObject var sessionVm = SessionViewModel()
    @StateObject var loginVm = LoginViewModel()
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
            .environmentObject(sessionVm)
            .environmentObject(loginVm)
            .environmentObject(perform)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
}




