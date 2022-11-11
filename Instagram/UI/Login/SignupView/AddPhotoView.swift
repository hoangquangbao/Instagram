import SwiftUI

struct AddPhotoView: View {
    
    @EnvironmentObject var vm: SignupViewModel
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SignupAddView(vm: vm.addPhotoVM,
                              text: $vm.email,
                              isNavigation: $_isNavigation)
                
                NavigationLink("", destination: SharePhotoView(), isActive: $_isNavigation)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AddPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotoView()
            .environmentObject(SignupViewModel())
    }
}
