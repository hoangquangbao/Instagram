import SwiftUI

@available(iOS 16.0, *)
struct AddPhotoView: View {
    
    @EnvironmentObject var vm: SignupViewModel
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                SignupAddView(vm: vm.addPhotoVM,
                              text: $vm.email,
                              isNavigation: $_isNavigation)
            }
            .navigationDestination(isPresented: $_isNavigation,
                                   destination: { SharePhotoView() })
        }
        .navigationBarBackButtonHidden(true)
    }
}

@available(iOS 16.0, *)
struct AddPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotoView()
            .environmentObject(SignupViewModel())
    }
}
