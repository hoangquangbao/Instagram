import SwiftUI

enum OnScreen {
    case add_email
    case add_confirmation_code
    case add_full_name
    case add_password
    case add_birthday
    case add_username
    case signup_account
    case find_friend
    case add_photo
    case share_photo
}

class SignupAddViewModel: ObservableObject {
    
    let type: OnScreen
    
    let headerTitle: String
    let pickerTitle: [String]?
    let textfieldTitle: String?
    let buttonLable: String
    let saveTitle: String?
    let imageSystemName: String?
    let imageSystemName_ext: String?
    let description: String
    let description_ext: String?
    let questionText: String?
    let actionText: String?
    
    init(type: OnScreen = .add_email,
         headerTitle: String = "",
         pickerTitle: [String]? = nil,
         textfieldTitle: String? = nil,
         buttonLable: String = "",
         saveTitle: String? = nil,
         imageSystemName: String? = nil,
         imageSystemName_ext: String? = nil,
         description: String = "",
         description_ext: String? = nil,
         questionText: String? = nil,
         actionText: String? = nil)
    {
        self.type = type
        self.headerTitle = headerTitle
        self.pickerTitle = pickerTitle
        self.textfieldTitle = textfieldTitle
        self.buttonLable = buttonLable
        self.saveTitle = saveTitle
        self.imageSystemName = imageSystemName
        self.imageSystemName_ext = imageSystemName_ext
        self.description = description
        self.description_ext = description_ext
        self.questionText = questionText
        self.actionText = actionText
    }
}
