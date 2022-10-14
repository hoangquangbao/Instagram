import SwiftUI

struct EnterYourNameView: View {
    
    @EnvironmentObject var vm: SignUpViewModel
    @EnvironmentObject var perform: BackLoginView
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                SignupInputView(vm: vm.addNameVM,
                                text: $vm.fullName,
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

struct EnterYourNameView_Previews: PreviewProvider {
    static var previews: some View {
        EnterYourNameView()
    }
}
