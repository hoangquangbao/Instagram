import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    func handleSignUp() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            
            if let error = error {
                print("SignUp faild: \(error.localizedDescription)")
                return
            }
            print("Successfully create user: \(result?.user.uid ?? "")")
        }
    }
    
    func handleLogin() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("SignIn faild: \(error.localizedDescription)")
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
        }
    }
    
    func handleResetPassword() {
        FirebaseManager.shared.auth.sendPasswordReset(withEmail: email) { error in
            print(error?.localizedDescription ?? "Email Link Sent. We sent an email to " + self.email + " with a link to get back into your account")
        }
    }
    
    func textFieldIsEmpty() -> Bool {
        return email.isEmpty || password.isEmpty
    }
    
    //MARK: Validate an email address
    func validateEmailFormat() -> Bool {
        if email.count > 100 {
            return false
        }
        
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    func validateAccountExist(completion: @escaping (Bool, Error?) -> Void) {
        FirebaseManager.shared.auth.fetchSignInMethods(forEmail: email) { array, error in
            completion((array?.isEmpty) != nil, error)
        }
    }
    
    func resetTextField() {
        self.email = ""
        self.password = ""
    }
}
