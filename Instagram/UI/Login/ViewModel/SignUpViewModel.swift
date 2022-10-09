import SwiftUI

class SignUpViewModel: ObservableObject {
    
    @Published var email: String
    @Published var password: String
    
    var headerTitle: String
    var pickerTitles: [String]
    var emailTitle: String
    var nextButtonTitle: String
    var phoneOptionDescription: String
    var questionText: String
    var actionText: String
    
    init() {
        self.email = ""
        self.password = ""
        self.headerTitle = "Enter Phone or Email"
        self.pickerTitles = ["Phone", "Email"]
        self.emailTitle = "Email Address"
        self.nextButtonTitle = "Next"
        self.phoneOptionDescription = "You may receive SMS notification from us for security and login purposes."
        self.questionText = "Already have an account?"
        self.actionText = "Sign In."
    }
    
    func handleSignUp() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("Successfully create user: \(result?.user.uid ?? "")")
        }
    }
}
