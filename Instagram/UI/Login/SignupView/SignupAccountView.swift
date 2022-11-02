import SwiftUI

@available(iOS 16.0, *)
struct SignupAccountView: View {
    
    @EnvironmentObject var vm: SignupViewModel
    @EnvironmentObject var perform: BackLoginViewModel
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SignupAddView(vm: vm.signupAccountVM,
                              text: $vm.email,
                              isNavigation: $_isNavigation)
                
                BottomBarView(questionText: vm.addEmailVM.questionText,
                              actionText: vm.addEmailVM.actionText ?? "") {
                    perform.isBackLoginView_ext = false
                }
                              .padding(.top, 30)
            }
            .navigationDestination(isPresented: $_isNavigation,
                                   destination: { FindFriendView() })
        }
        .navigationBarBackButtonHidden(true)
    }
}

@available(iOS 16.0, *)
struct SignupAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SignupAccountView()
            .environmentObject(SignupViewModel())
    }
}
