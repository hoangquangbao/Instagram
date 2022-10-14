import SwiftUI

class SignUpViewModel: ObservableObject {
    
    @Published var email: String
    @Published var code: String
    @Published var fullName: String
    @Published var password: String
    @Published var birthday: String
    @Published var age: String
    @Published var username: String
    
    var addEmailVM: SignupInputViewModel
    var addConfirmationCodeVM: SignupInputViewModel
    var addNameVM: SignupInputViewModel
    
    init(email: String = "",
         code: String = "",
         fullName: String = "",
         password: String = "",
         birthday: String = "",
         age: String = "",
         username: String = "")
    {
        self.email = email
        self.code = code
        self.fullName = fullName
        self.password = password
        self.birthday = birthday
        self.age = age
        self.username = username
        self.addEmailVM = SignupInputViewModel(
            type: .add_email,
            headerTitle: "Enter Phone or Email",
            pickerTitle: ["Phone", "Email"],
            textfieldTitle: "Email Address",
            buttonLable: "Next",
            description: "You may receive SMS notification from us for security and login purpose.",
            questionText: "Already have an account?",
            actionText: "Sign In",
            action: {
                return email.isEmpty
            })
        self.addConfirmationCodeVM = SignupInputViewModel(
            type: .add_confirmation_code,
            headerTitle: "Enter confirmation code",
            textfieldTitle: "Confirmation code",
            buttonLable: "Next",
            description: "Enter confirmation code we send",
            actionText: "Resend confirmation code.",
            action: {
                return code.isEmpty
            })
        self.addNameVM = SignupInputViewModel(
            type: .add_name,
            headerTitle: "Add Your Name",
            textfieldTitle: "Full name",
            buttonLable: "Next",
            description: "Add your name so friend can find you.",
            questionText: "Already have an account?",
            actionText: "Sign In",
            action: {
                return fullName.isEmpty
            })
    }
}
