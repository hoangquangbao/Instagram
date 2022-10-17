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
    @Published var profileImageUrl: String
    
    var addEmailVM: SignupAddViewModel
    var addConfirmationCodeVM: SignupAddViewModel
    var addNameVM: SignupAddViewModel
    var addPasswordVM: SignupAddViewModel
    var addBirthdayVM: SignupAddViewModel
    var addUsernameVM: SignupAddViewModel
    var addPhotoVM: SignupAddViewModel
    var signupAccountVM: SignupAddViewModel
    var findFriendVM: SignupAddViewModel
    
    init(email: String = "",
         code: String = "",
         fullName: String = "",
         password: String = "",
         isSavePassword: Bool = false,
         birthday: String = "",
         age: String = "",
         username: String = "",
         profileImageUrl: String = "")
    {
        self.email = email
        self.code = code
        self.fullName = fullName
        self.password = password
        self.isSavePassword = isSavePassword
        self.birthday = birthday
        self.age = age
        self.username = username
        self.profileImageUrl = profileImageUrl
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
        self.addBirthdayVM = SignupAddViewModel(
            type: .add_birthday,
            headerTitle: "Add your birthday",
            textfieldTitle: " years old",
            buttonLable: "Next",
            description: "This won't be part of your public profile.",
            description_ext: "Use your own birthday, even if this account is for a business, a pet or something else.",
            actionText: "Why I need to provide my birthday?",
            action: {
                return true
            })
        self.addUsernameVM = SignupAddViewModel(
            type: .add_username,
            headerTitle: "Create username",
            textfieldTitle: "Username",
            buttonLable: "Next",
            description: "Pick a username for your new account. You can always change it later.",
            questionText: "Already have an account?",
            actionText: "Sign In",
            action: {
                return username.isEmpty
            })
        self.signupAccountVM = SignupAddViewModel(
            type: .signup_account,
            headerTitle: "Sign up as?",
            buttonLable: "Sign up",
            description: "You can always change your username later.",
            description_ext: "People who use our service may have uploaded your contact information to Instagram. **[Learn more](https://help.instagram.com/1128997980474717)**.\n\nBy tapping Sign up, you agree to our **[Terms, Data Policy](https://privacycenter.instagram.com/policy)** and **[Cookies Policy](https://help.instagram.com/1896641480634370)**.",
            questionText: "Already have an account?",
            actionText: "Sign In",
            action: {
                return true
            })
        self.addPhotoVM = SignupAddViewModel(
            type: .add_photo,
            headerTitle: "Add profile photo",
            buttonLable: "Add a photos",
            description: "Add a profile photo so your friend know it's you.",
            actionText: "Skip",
            action: {
                return true
            },
            action_ext: {
                
            })
        self.findFriendVM = SignupAddViewModel(
            type: .find_friend,
            headerTitle: "Find Facebook Friends",
            buttonLable: "Find friends",
            description: "You choose which friends to follow. We'll never post to Facebook without your permission.",
            actionText: "Skip",
            action: {
                return true
            },
            action_ext: {
                
            })
    }
}
