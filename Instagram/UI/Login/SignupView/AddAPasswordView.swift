import SwiftUI

struct AddAPasswordView: View {
    
    @EnvironmentObject var vm: SignupViewModel
    @EnvironmentObject var perform: BackLoginViewModel
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                SignupAddView(vm: vm.addPasswordVM,
                              text: $vm.password,
                              isNavigation: $_isNavigation)
                
                Divider()
                    .padding(.bottom, 10)
                
                BottomBarView(questionText: vm.addPasswordVM.questionText,
                              actionText: vm.addEmailVM.actionText ?? "") {
                    perform.isBackLoginView_ext = false
                }
                
                NavigationLink("", destination: AddYourBirthdayView(), isActive: $_isNavigation)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AddAPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        AddAPasswordView()
            .environmentObject(SignupViewModel())
    }
}
