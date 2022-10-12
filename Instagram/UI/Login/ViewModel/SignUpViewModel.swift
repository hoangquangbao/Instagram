import SwiftUI

class SignUpViewModel: ObservableObject {
    
    @Published var email: String
    @Published var code: String
    @Published var fullName: String
    @Published var password: String
    @Published var birthday: String
    @Published var age: String
    @Published var username: String

    @Published var isShowConfirmationCodeView: Bool?
    @Published var isShowAddYourNameView: Bool?
    
    var headerTitle: String
    var pickerTitles: [String]?
    var textFieldTitle: String
    var nextButtonTitle: String
    var description: String
    var questionText: String?
    var actionText: String?
    
    init(email: String = "",
         code: String = "",
         fullName: String = "",
         password: String = "",
         birthday: String = "",
         age: String = "",
         username: String = "",
         isShowConfirmationCodeView: Bool? = nil,
         isShowAddYourNameView:Bool? = nil,
         headerTitle: String,
         pickerTitles: [String]? = nil,
         textFieldTitle: String,
         nextButtonTitle: String,
         description: String,
         questionText: String? = nil,
         actionText: String? = nil) {
        self.email = email
        self.code = code
        self.fullName = fullName
        self.password = password
        self.birthday = birthday
        self.age = age
        self.username = username
        self.isShowConfirmationCodeView = isShowConfirmationCodeView
        self.isShowAddYourNameView = isShowAddYourNameView
        self.headerTitle = headerTitle
        self.pickerTitles = pickerTitles
        self.textFieldTitle = textFieldTitle
        self.nextButtonTitle = nextButtonTitle
        self.description = description
        self.questionText = questionText
        self.actionText = actionText
    }
    
    func registerEmail() {
        withAnimation {
            self.isShowConfirmationCodeView = true
        }
    }
}
