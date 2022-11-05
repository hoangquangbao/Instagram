import SwiftUI

struct AddYourNameView: View {
    
    @EnvironmentObject var vm: SignupViewModel
    @EnvironmentObject var perform: BackLoginViewModel
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                SignupAddView(vm: vm.addNameVM,
                              text: $vm.fullName,
                              isNavigation: $_isNavigation)
                
                Divider()
                    .padding(.bottom, 10)
                
                BottomBarView(questionText: vm.addNameVM.questionText,
                              actionText: vm.addEmailVM.actionText ?? "") {
                    perform.isBackLoginView_ext = false
                }
                
                NavigationLink("", destination: AddAPasswordView(), isActive: $_isNavigation)
            }
            .edgesIgnoringSafeArea(.bottom)
//            .navigationDestination(isPresented: $_isNavigation,
//                                   destination: { AddAPasswordView() })
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AddYourNameView_Previews: PreviewProvider {
    static var previews: some View {
        AddYourNameView()
            .environmentObject(SignupViewModel())
    }
}
