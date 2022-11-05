import SwiftUI

class SignupViewModel: ObservableObject {
    let userService = UserService()
    @EnvironmentObject var sessionService: SessionService
    
    ///Get data from SignupView
    @Published var email: String
    @Published var code: String
    @Published var fullName: String
    @Published var password: String
    @Published var isSavePassword: Bool
    @Published var birthday: String
    @Published var age: String
    @Published var username: String
    @Published var avatarImage: UIImage?
    ///Other View
    @Published var hasStory: Bool
    @Published var followings: [String]
    @Published var followers: [String]
    @Published var isOnline: Bool
    @Published var description: String
    
    @Published var isShowAlert : Bool = false
    @Published var alertTitle : String = ""
    @Published var alertButtonTitle : String = ""
    @Published var alertMessage : String = ""
    
    var addEmailVM: SignupAddViewModel
    var addConfirmationCodeVM: SignupAddViewModel
    var addNameVM: SignupAddViewModel
    var addPasswordVM: SignupAddViewModel
    var addBirthdayVM: SignupAddViewModel
    var addUsernameVM: SignupAddViewModel
    var signupAccountVM: SignupAddViewModel
    var findFriendVM: SignupAddViewModel
    var addPhotoVM: SignupAddViewModel
    var sharePhotoVM: SignupAddViewModel
    
    init(email: String = "",
         code: String = "",
         fullName: String = "",
         password: String = "",
         isSavePassword: Bool = false,
         birthday: String = "",
         age: String = "",
         username: String = "",
         avatarImage: UIImage? = nil,
         hasStory: Bool = false,
         followings: [String] = [],
         followers: [String] = [],
         isOnline: Bool = false,
         description: String = "")
    {
        self.email = email
        self.code = code
        self.fullName = fullName
        self.password = password
        self.isSavePassword = isSavePassword
        self.birthday = birthday
        self.age = age
        self.username = username
        self.avatarImage = avatarImage
        self.hasStory = hasStory
        self.followings = followings
        self.followers = followers
        self.isOnline = isOnline
        self.description = description
        
        self.addEmailVM = SignupAddViewModel(
            type: .add_email,
            headerTitle: "Enter Phone or Email",
            pickerTitle: ["Phone", "Email"],
            textfieldTitle: "Email Address",
            buttonLable: "Next",
            description: "You may receive SMS notification from us for security and login purpose.",
            questionText: "Already have an account?",
            actionText: "Sign In")
        self.addConfirmationCodeVM = SignupAddViewModel(
            type: .add_confirmation_code,
            headerTitle: "Enter confirmation code",
            textfieldTitle: "Confirmation code",
            buttonLable: "Next",
            description: "Enter confirmation code we send",
            actionText: "Resend confirmation code.")
        self.addNameVM = SignupAddViewModel(
            type: .add_full_name,
            headerTitle: "Add Your Name",
            textfieldTitle: "Full name",
            buttonLable: "Next",
            description: "Add your name so friend can find you.",
            questionText: "Already have an account?",
            actionText: "Sign In")
        self.addPasswordVM = SignupAddViewModel(
            type: .add_password,
            headerTitle: "Create a password",
            textfieldTitle: "Password",
            buttonLable: "Next",
            saveTitle: "Save Password",
            imageSystemName: "checkmark.square.fill",
            imageSystemName_ext: "square",
            description: "We can remember the password, so you won't need to enter it on your iCloud® devices.",
            questionText: "Already have an account?",
            actionText: "Sign In")
        self.addBirthdayVM = SignupAddViewModel(
            type: .add_birthday,
            headerTitle: "Add your birthday",
            textfieldTitle: " years old",
            buttonLable: "Next",
            imageSystemName: "gift",
            description: "This won't be part of your public profile.",
            description_ext: "Use your own birthday, even if this account is for a business, a pet or something else.",
            questionText: "You need to enter the day you were born",
            actionText: "[Why I need to provide my birthday?](https://help.instagram.com/366075557613433)")
        self.addUsernameVM = SignupAddViewModel(
            type: .add_username,
            headerTitle: "Create username",
            textfieldTitle: "Username",
            buttonLable: "Next",
            description: "Pick a username for your new account. You can always change it later.",
            questionText: "Already have an account?",
            actionText: "Sign In")
        self.signupAccountVM = SignupAddViewModel(
            type: .signup_account,
            headerTitle: "Sign up as ",
            buttonLable: "Sign up",
            description: "You can always change your username later.",
            description_ext: "People who use our service may have uploaded your contact information to Instagram. **[Learn more](https://help.instagram.com/1128997980474717)**.\n\nBy tapping Sign up, you agree to our **[Terms, Data Policy](https://privacycenter.instagram.com/policy)** and **[Cookies Policy](https://help.instagram.com/1896641480634370)**.",
            questionText: "Already have an account?",
            actionText: "Sign In")
        self.findFriendVM = SignupAddViewModel(
            type: .find_friend,
            headerTitle: "Find Facebook Friends",
            buttonLable: "Find friends",
            imageSystemName: "magnifyingglass.circle",
            description: "You choose which friends to follow. We'll never post to Facebook without your permission.",
            actionText: "Skip")
        self.addPhotoVM = SignupAddViewModel(
            type: .add_photo,
            headerTitle: "Add profile photo",
            buttonLable: "Add a photos",
            imageSystemName: "person.crop.circle.badge.plus",
            description: "Add a profile photo so your friend know it's you.",
            actionText: "Skip")
        self.sharePhotoVM = SignupAddViewModel(
            type: .share_photo,
            headerTitle: "Profile photo added",
            buttonLable: "Next",
            imageSystemName: "person.fill",
            description: "Make this photo your first post so people can like and comment on it.",
            questionText: "Also share this photo as a post",
            actionText: "Change photo")
    }
    
    func validateAccountExist(completion: @escaping (Bool, Error?) -> Void) {
        FirebaseManager.shared.auth.fetchSignInMethods(forEmail: email) { array, error in
            completion(array?.isEmpty != nil, error)
        }
    }
    
    func validateEmailFormat(completion: (Bool) -> Void) {
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        completion(emailPredicate.evaluate(with: email))
    }
    
    func signupAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email,
                                               password: password) { result, error in
            if let error = error {
                self.isShowAlert = true
                self.alertMessage = error.localizedDescription
                print(error.localizedDescription)
                return
            }
            
            if self.avatarImage == nil {
                self.avatarImage = UIImage(named: "img_avatar_default")
                self.uploadAvatarImage()
            } else {
                self.uploadAvatarImage()
            }
        }
    }
    
    func uploadAvatarImage() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        guard let imageData = avatarImage?.jpegData(compressionQuality: 0.5) else { return }
        
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.isShowAlert = true
                self.alertMessage = err.localizedDescription
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    self.isShowAlert = true
                    self.alertMessage = err.localizedDescription
                    return
                }
                guard let url = url else { return }
                self.storeUserInfo(avatarUrl: url)
            }
        }
    }
    
    func storeUserInfo(avatarUrl: URL) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let user = User(id: uid, email: email, username: username, fullName: fullName, avatarUrl: avatarUrl.absoluteString)
        
        userService.create(user) { isSuccess, error in
            if let error = error {
                self.isShowAlert = true
                self.alertTitle = "Register a new account"
                self.alertMessage = error.localizedDescription
                print(error.localizedDescription)
                return
            }
            
            //Show alert successfully created
            self.isShowAlert = true
            self.alertTitle = "Instagram account"
            self.alertButtonTitle = "Got it!"
            self.alertMessage = "Your account has been successfully cereated!"
        }
    }
}
