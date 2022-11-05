import SwiftUI

struct SharePhotoView: View {
    
    @EnvironmentObject var vm: SignupViewModel
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
//            .navigationDestination(isPresented: $_isNavigation,
//                                   destination: { TabbarBottomView() })
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
