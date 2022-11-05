import SwiftUI

struct FindFriendView: View {
    
    @EnvironmentObject var vm: SignupViewModel
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SignupAddView(vm: vm.findFriendVM,
                              text: $vm.email,
                              isNavigation: $_isNavigation)
                
                NavigationLink("", destination: AddPhotoView(), isActive: $_isNavigation)
            }
            .edgesIgnoringSafeArea(.bottom)
//            .navigationDestination(isPresented: $_isNavigation,
//                                   destination: { AddPhotoView() })
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FindFriendView_Previews: PreviewProvider {
    static var previews: some View {
        FindFriendView()
            .environmentObject(SignupViewModel())
    }
}
