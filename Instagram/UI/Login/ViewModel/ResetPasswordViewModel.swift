import SwiftUI

class ResetPasswordViewModel: ObservableObject {
    
    var headerTitle: String
    var pickerTitles: [String]
    var phoneOptionDescription: String
    var usernameOptionDescription: String
    var emailTitle: String
    var nextButtonTitle: String
    var resetQuestionText: String
    var actionText: String

    init() {
        self.headerTitle = "Trouble logging in?"
        self.pickerTitles = ["Username", "Phone"]
        self.phoneOptionDescription = "Enter your username or email and we'll send you a link to get back into your account."
        self.usernameOptionDescription = "Enter your phone number and we'll send you a login code to get back into your account."
        self.emailTitle = "Username or email"
        self.nextButtonTitle = "Next"
        self.resetQuestionText = "Can't reset your password?"
        self.actionText = "Back to log in"
    }
    
    func handleResetPassword(email: String, completion: @escaping (Bool) -> Void) {
        FirebaseManager.shared.auth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            print("Email Link Sent. We sent an email to " + email + " with a link to get back into your account")
            completion(true)
        }
    }
}
