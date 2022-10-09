import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var email: String
    @Published var password: String
    @Published var isShowSignUpView: Bool = false
    @Published var isShowResetPasswordView: Bool = false
    
    var emailTitle: String
    var passwordTitle: String
    var forgotPasswordText: String
    var loginButtonTitle: String
    var questionText: String
    var actionText: String
    
    // MARK: SubViewModel
    var signUpVM: SignUpViewModel
    
    init() {
        self.email = ""
        self.password = ""
        
        self.emailTitle = "Email Address"
        self.passwordTitle = "Password"
        self.forgotPasswordText = "Forgot password?"
        self.loginButtonTitle = "Log in"
        self.questionText = "Don't have an account?"
        self.actionText = "Sign up."
        
        self.signUpVM = SignUpViewModel()
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
    
    func resetTextField() {
        self.email = ""
        self.password = ""
    }
}
