import SwiftUI

struct AddConfirmationCodeView: View {
    
    @EnvironmentObject var vm: SignupViewModel
    @Environment(\.dismiss) var dismiss
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                SignupAddView(vm: vm.addConfirmationCodeVM,
                              text: $vm.code,
                              isNavigation: $_isNavigation)
                
                NavigationLink("", destination: AddYourNameView(), isActive: $_isNavigation)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image.icnBack
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AddConfirmationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        AddConfirmationCodeView()
            .environmentObject(SignupViewModel())
    }
}
