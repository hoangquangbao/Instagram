import SwiftUI

struct AddYourNameView: View {
    
    @EnvironmentObject var vm: SignUpViewModel
    @Environment(\.dismiss) var dismiss
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                SignupInputView(vm: vm.addNameVM,
                                text: $vm.fullName,
                                isNavigation: $_isNavigation)
                
                BottomBarView(questionText: vm.addEmailVM.questionText,
                              actionText: vm.addEmailVM.actionText ?? "") { dismiss() }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AddYourNameView_Previews: PreviewProvider {
    static var previews: some View {
        AddYourNameView()
    }
}

