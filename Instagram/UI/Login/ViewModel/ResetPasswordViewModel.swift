import SwiftUI

class ResetPasswordViewModel: ObservableObject {
    
    let headerTitle: String
    let pickerTitles: [String]
    let phoneOptionDescription: String
    let usernameOptionDescription: String
    let emailTitle: String
    let nextButtonTitle: String
    let resetQuestionText: String
    let actionText: String
    
    init(headerTitle: String = "Trouble logging in?",
         pickerTitles: [String] = ["Username", "Phone"],
         phoneOptionDescription: String = "Enter your username or email and we'll send you a link to get back into your account.",
         usernameOptionDescription: String = "Enter your phone number and we'll send you a login code to get back into your account.",
         emailTitle: String = "Username or email",
         nextButtonTitle: String = "Next",
         resetQuestionText: String = "Can't reset your password?",
         actionText: String = "Back to log in")
    {
        self.headerTitle = headerTitle
        self.pickerTitles = pickerTitles
        self.phoneOptionDescription = phoneOptionDescription
        self.usernameOptionDescription = usernameOptionDescription
        self.emailTitle = emailTitle
        self.nextButtonTitle = nextButtonTitle
        self.resetQuestionText = resetQuestionText
        self.actionText = actionText
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
