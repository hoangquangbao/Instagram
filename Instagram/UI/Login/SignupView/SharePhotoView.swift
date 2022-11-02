import SwiftUI

@available(iOS 16.0, *)
struct SharePhotoView: View {
    
    @EnvironmentObject var vm: SignupViewModel
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SignupAddView(vm: vm.sharePhotoVM,
                              text: $vm.email,
                              isNavigation: $_isNavigation)
            }
            .navigationDestination(isPresented: $_isNavigation,
                                   destination: { TabbarBottomView() })
        }
        .navigationBarBackButtonHidden(true)
    }
}

@available(iOS 16.0, *)
struct SharePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        SharePhotoView()
            .environmentObject(SignupViewModel())
    }
}
