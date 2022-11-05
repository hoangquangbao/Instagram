import SwiftUI

@main
struct InstagramApp: App {
    @StateObject var sessionService = SessionService()
    @StateObject var vm = LoginViewModel()
    @StateObject var perform = BackLoginViewModel()
    @StateObject var userData = UserData()
    @StateObject var postData = PostData()
    
    
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
            .environmentObject(userData)
            .environmentObject(postData)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
}
