import SwiftUI

@available(iOS 16.0, *)
@main
struct InstagramApp: App {
    @StateObject var sessionViewModel = SessionViewModel()
    @StateObject var vm = LoginViewModel()
    @StateObject var perform = BackLoginViewModel()
    @StateObject var userVm = UserViewModel()
    @StateObject var postVm = PostViewModel()
    @StateObject var storyData = StoryViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if isLoggedIn() {
                    TabbarBottomView()
                } else {
                    LoginView()
                }
            }
            .environmentObject(sessionViewModel)
            .environmentObject(vm)
            .environmentObject(perform)
            .environmentObject(userVm)
            .environmentObject(postVm)
            .environmentObject(storyData)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
}



