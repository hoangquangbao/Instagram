import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var email: String
    @Published var password: String
    @Published var isShowResetPasswordView: Bool
    
    @Published var isShowAlert : Bool = false
    @Published var alertTitle : String = ""
    @Published var alertButtonTitle : String = ""
    @Published var alertMessage : String = ""
    
    @Published var isShowHomeView: Bool = false
    
    let emailTitle: String
    let passwordTitle: String
    let forgotPasswordText: String
    let loginButtonTitle: String
    let questionText: String
    let actionText: String
    
    init(email: String = "",
         password: String = "",
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
        self.isShowResetPasswordView = isShowResetPasswordView
        self.emailTitle = emailTitle
        self.passwordTitle = passwordTitle
        self.forgotPasswordText = forgotPasswordText
        self.loginButtonTitle = loginButtonTitle
        self.questionText = questionText
        self.actionText = actionText
    }
    
    func handleLogin() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.isShowAlert = true
                self.alertTitle = "Login account"
                self.alertButtonTitle = "OK"
                self.alertMessage = error.localizedDescription
                return
            } else {
                self.isShowHomeView = true
            }
            
            self.email = ""
            self.password = ""
            self.isShowHomeView = true
        }
    }
    
    func textFieldIsEmpty() -> Bool {
        return email.isEmpty || password.isEmpty
    }
}
