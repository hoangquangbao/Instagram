import SwiftUI

class BackLoginView: ObservableObject {
    @Published var isBackLoginView: Bool = false
}

class SignupViewModel: ObservableObject {
    
    @Published var email: String
    @Published var code: String
    @Published var fullName: String
    @Published var password: String
    @Published var isSavePassword: Bool
    @Published var birthday: String
    @Published var age: String
    @Published var username: String
    
    var addEmailVM: SignupAddViewModel
    var addConfirmationCodeVM: SignupAddViewModel
    var addNameVM: SignupAddViewModel
    var addPasswordVM: SignupAddViewModel
    
    init(email: String = "",
         code: String = "",
         fullName: String = "",
         password: String = "",
         isSavePassword: Bool = false,
         birthday: String = "",
         age: String = "",
         username: String = "")
    {
        self.email = email
        self.code = code
        self.fullName = fullName
        self.password = password
        self.isSavePassword = isSavePassword
        self.birthday = birthday
        self.age = age
        self.username = username
        self.addEmailVM = SignupAddViewModel(
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
        self.addConfirmationCodeVM = SignupAddViewModel(
            type: .add_confirmation_code,
            headerTitle: "Enter confirmation code",
            textfieldTitle: "Confirmation code",
            buttonLable: "Next",
            description: "Enter confirmation code we send",
            actionText: "Resend confirmation code.",
            action: {
                return code.isEmpty
            })
        self.addNameVM = SignupAddViewModel(
            type: .add_full_name,
            headerTitle: "Add Your Name",
            textfieldTitle: "Full name",
            buttonLable: "Next",
            description: "Add your name so friend can find you.",
            questionText: "Already have an account?",
            actionText: "Sign In",
            action: {
                return fullName.isEmpty
            })
        self.addPasswordVM = SignupAddViewModel(
            type: .add_password,
            headerTitle: "Create a password",
            textfieldTitle: "Password",
            buttonLable: "Next",
            saveTitle: "Save Password",
            description: "We can remember the password, so you won't need to enter it on your iCloud® devices.",
            questionText: "Already have an account?",
            actionText: "Sign In",
            action: {
                return password.isEmpty
            })
    }
}
