import SwiftUI

@available(iOS 16.0, *)
struct ConfirmationCodeView: View {
    
    @EnvironmentObject var vm: SignUpViewModel
    @Environment(\.dismiss) var dismiss
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                SignupInputView(vm: vm.addConfirmationCodeVM,
                                text: $vm.code,
                                isNavigation: $_isNavigation)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image.icnBack
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
            }
            .navigationDestination(isPresented: $_isNavigation,
                                   destination: { AddYourNameView() })
        }
        .navigationBarBackButtonHidden(true)
    }
}

@available(iOS 16.0, *)
struct ConfirmationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationCodeView()
    }
}
