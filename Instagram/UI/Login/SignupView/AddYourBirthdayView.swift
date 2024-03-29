import SwiftUI

struct AddYourBirthdayView: View {
    
    @EnvironmentObject var vm: SignupViewModel
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SignupAddView(vm: vm.addBirthdayVM,
                              text: $vm.birthday,
                              isNavigation: $_isNavigation)
                
                NavigationLink("", destination: AddUsernameView(), isActive: $_isNavigation)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AddYourBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        AddYourBirthdayView()
            .environmentObject(SignupViewModel())
    }
}
