//import SwiftUI
//
//enum Signup {
//    case add_email
//    case add_confirmation_code
//    case add_name
//    
//    init(onScreen: Signup) {
//        switch onScreen {
//        case .add_email:
//            self = .add_email
//        case .add_confirmation_code:
//            self = .add_confirmation_code
//        default:
//            self = .add_name
//        }
//    }
//    
//    var signUpViewModel: SignUpViewModel {
//        get {
//            switch self {
//            case .add_email:
//                return SignUpViewModel(email: "",
//                                       isShowConfirmationCodeView: false,
//                                       headerTitle: "Enter Phone or Email",
//                                       pickerTitles: ["Phone", "Email"],
//                                       textFieldTitle: "Email Address",
//                                       nextButtonTitle: "Next",
//                                       description: "You may receive SMS notification from us for security and login purpose.",
//                                       questionText: "Already have an account?",
//                                       actionText: "Sign In.")
//            case .add_confirmation_code:
//                return SignUpViewModel(code: "",
//                                       isShowAddYourNameView: false,
//                                       headerTitle: "Enter confirmation code",
//                                       textFieldTitle: "Confirmation code",
//                                       nextButtonTitle: "Next",
//                                       description: "Enter confirmation code we send to ",
//                                       actionText: " Resend confirmation code.")
//            case .add_name:
//                return SignUpViewModel(fullName: "",
//                                       headerTitle: "Add Your Name",
//                                       textFieldTitle: "Full name",
//                                       nextButtonTitle: "Next",
//                                       description: "Add your name so friend can find you.",
//                                       questionText: "Already have an account?",
//                                       actionText: "Sign In.")
//            }
//        }
//    }
//}
