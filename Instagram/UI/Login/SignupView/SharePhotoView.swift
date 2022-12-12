import SwiftUI

struct SharePhotoView: View {
    
    @EnvironmentObject var loginVm: LoginViewModel
    @EnvironmentObject var perform: BackLoginViewModel
    @EnvironmentObject var vm: SignupViewModel
    @EnvironmentObject var sessionVm: SessionViewModel
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SignupAddView(vm: vm.sharePhotoVM,
                              text: $vm.email,
                              isNavigation: $_isNavigation)
                
                NavigationLink("", destination: TabbarBottomView(), isActive: $_isNavigation)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SharePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        SharePhotoView()
            .environmentObject(SignupViewModel())
    }
}
