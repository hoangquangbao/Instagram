import SwiftUI

struct AddAPasswordView: View {
    
    @EnvironmentObject var vm: SignUpViewModel
    @EnvironmentObject var perform: BackLoginView
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                SignupInputView(vm: vm.addPasswordVM,
                                text: $vm.password,
                                isNavigation: $_isNavigation)
                
                BottomBarView(questionText: vm.addEmailVM.questionText,
                              actionText: vm.addEmailVM.actionText ?? "") {
                    perform.isBackLoginView = false
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AddAPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        AddAPasswordView()
    }
}
