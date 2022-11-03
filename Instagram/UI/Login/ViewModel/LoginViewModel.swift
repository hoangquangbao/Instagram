import SwiftUI
import FirebaseAuth

class BackLoginViewModel: ObservableObject {
    @Published var isBackLoginView: Bool = false
    @Published var isBackLoginView_ext: Bool = false
}

class LoginViewModel: ObservableObject {
    let userService = UserService()
    
    @Published var email: String
    @Published var password: String
    @Published var isShowLoginView: Bool
    @Published var isShowResetPasswordView: Bool
    
    @Published var isShowAlert : Bool = false
    @Published var alertTitle : String = ""
    @Published var alertButtonTitle : String = ""
    @Published var alertMessage : String = ""
    
    @Published var isShowTabbarBottomView: Bool = false
    
    let emailTitle: String
    let passwordTitle: String
    let forgotPasswordText: String
    let loginButtonTitle: String
    let questionText: String
    let actionText: String
    
    init(email: String = "",
         password: String = "",
         isShowLoginView: Bool = false,
         isShowResetPasswordView: Bool = false,
         emailTitle: String = "Email Address",
         passwordTitle: String = "Password",
         forgotPasswordText: String = "Forgot password",
         loginButtonTitle: String = "Log in",
         questionText: String = "Don't have an account?",
         actionText: String = "Sign up.")
    {
        self.email = email
        self.password = password
        self.isShowLoginView = isShowLoginView
        self.isShowResetPasswordView = isShowResetPasswordView
        self.emailTitle = emailTitle
        self.passwordTitle = passwordTitle
        self.forgotPasswordText = forgotPasswordText
        self.loginButtonTitle = loginButtonTitle
        self.questionText = questionText
        self.actionText = actionText
    }
    
    func handleLogin(completion: @escaping (String) -> Void) {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.isShowAlert = true
                self.alertTitle = "Login account"
                self.alertButtonTitle = "OK"
                self.alertMessage = error.localizedDescription
                return
            } else {
                UserDefaults.standard.setIsLoggedIn(value: true)
                withAnimation(.easeOut(duration: 0.1)) {
                    self.isShowTabbarBottomView = true
                }
            }
            
            self.email = ""
            self.password = ""
            
            guard let uid = result?.user.uid else { return }
            
            completion(uid)
            
            print("success")
        }
    }
    
    func handleLogout(completion: @escaping (Bool) -> Void) {
        do {
            try FirebaseManager.shared.auth.signOut()
            UserDefaults.standard.setIsLoggedIn(value: false)
            self.isShowTabbarBottomView = false
            completion(false)
            print ("Logout success!")
        }
        catch let logoutError as NSError {
            completion(true)
            print ("Error Logout: %@", logoutError)
        }
    }
    
    func textFieldIsEmpty() -> Bool {
        return email.isEmpty || password.isEmpty
    }
    
}
