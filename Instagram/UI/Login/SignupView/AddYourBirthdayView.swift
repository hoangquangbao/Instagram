import SwiftUI

@available(iOS 16.0, *)
struct AddYourBirthdayView: View {
    
    @EnvironmentObject var vm: SignupViewModel
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SignupAddView(vm: vm.addBirthdayVM,
                              text: $vm.birthday,
                              isNavigation: $_isNavigation)
            }
            .navigationDestination(isPresented: $_isNavigation,
                                   destination: { AddUsernameView() })
        }
        .navigationBarBackButtonHidden(true)
    }
}

@available(iOS 16.0, *)
struct AddYourBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        AddYourBirthdayView()
            .environmentObject(SignupViewModel())
    }
}
