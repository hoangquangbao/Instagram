import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var email: String
    @Published var password: String
    @Published var isShowResetPasswordView: Bool
    
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
                print(error.localizedDescription)
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
        }
    }
    
    func textFieldIsEmpty() -> Bool {
        return email.isEmpty || password.isEmpty
    }
}
