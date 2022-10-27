import SwiftUI

@available(iOS 16.0, *)
struct FindFriendView: View {
    
    @EnvironmentObject var vm: SignupViewModel
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SignupAddView(vm: vm.findFriendVM,
                              text: $vm.email,
                              isNavigation: $_isNavigation)
            }
            .navigationDestination(isPresented: $_isNavigation,
                                   destination: { AddPhotoView() })
        }
        .navigationBarBackButtonHidden(true)
    }
}

@available(iOS 16.0, *)
struct FindFriendView_Previews: PreviewProvider {
    static var previews: some View {
        FindFriendView()
            .environmentObject(SignupViewModel())
    }
}
