import SwiftUI

enum OnScreen {
    case add_email
    case add_confirmation_code
    case add_full_name
    case add_password
}

class SignupAddViewModel: ObservableObject {
    
    let type: OnScreen
    
    let headerTitle: String
    let pickerTitle: [String]?
    let textfieldTitle: String
    let buttonLable: String
    let saveTitle: String?
    let description: String
    let questionText: String?
    let actionText: String?
    
    var action: ()->Bool
    
    init(type: OnScreen,
         headerTitle: String,
         pickerTitle: [String]? = nil,
         textfieldTitle: String,
         buttonLable: String,
         saveTitle: String? = nil,
         description: String,
         questionText: String? = nil,
         actionText: String? = nil,
         action: @escaping () -> Bool)
    {
        self.type = type
        self.headerTitle = headerTitle
        self.pickerTitle = pickerTitle
        self.textfieldTitle = textfieldTitle
        self.buttonLable = buttonLable
        self.saveTitle = saveTitle
        self.description = description
        self.questionText = questionText
        self.actionText = actionText
        self.action = action
    }
}