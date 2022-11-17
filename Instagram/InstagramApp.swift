import SwiftUI

@main
struct InstagramApp: App {
    @StateObject var sessionVm = SessionViewModel()
    @StateObject var vm = LoginViewModel()
    @StateObject var perform = BackLoginViewModel()
    @StateObject var userVm = UserViewModel()
    @StateObject var postVm = PostViewModel()
    @StateObject var storyVm = StoryViewModel()
    @StateObject var notificationVm = NotificationViewModel()
    
    
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
            .environmentObject(vm)
            .environmentObject(perform)
            .environmentObject(userVm)
            .environmentObject(postVm)
            .environmentObject(storyVm)
            .environmentObject(notificationVm)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
}




