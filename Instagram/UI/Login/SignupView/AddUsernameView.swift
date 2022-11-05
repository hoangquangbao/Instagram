import SwiftUI

struct AddUsernameView: View {
    
    @EnvironmentObject var vm: SignupViewModel
    @EnvironmentObject var perform: BackLoginViewModel
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                SignupAddView(vm: vm.addUsernameVM,
                              text: $vm.username,
                              isNavigation: $_isNavigation)
                
                Divider()
                    .padding(.bottom, 10)
                
                BottomBarView(questionText: vm.addUsernameVM.questionText,
                              actionText: vm.addEmailVM.actionText ?? "") {
                    perform.isBackLoginView_ext = false
                }
                
                NavigationLink("", destination: SignupAccountView(), isActive: $_isNavigation)
            }
            .edgesIgnoringSafeArea(.bottom)
//            .navigationDestination(isPresented: $_isNavigation,
//                                   destination: { SignupAccountView() })
        }
        .navigationBarBackButtonHidden(true)
//                    .edgesIgnoringSafeArea(.bottom)
        
//                        NavigationLink("", destination: SignupAccountView(), isActive: $_isNavigation)
    }
}

struct AddUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        AddUsernameView()
            .environmentObject(SignupViewModel())
    }
}
