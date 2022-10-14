import SwiftUI

@available(iOS 16.0, *)
struct EnterEmailView: View {
    
    @StateObject var vm = SignUpViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                SignupInputView(vm: vm.addEmailVM,
                                text: $vm.email,
                                isNavigation: $_isNavigation)
                
                BottomBarView(questionText: vm.addEmailVM.questionText,
                              actionText: vm.addEmailVM.actionText ?? "") { dismiss() }
            }
            .navigationTitle(Text(""))
            .navigationBarTitleDisplayMode(.inline)
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
                                   destination: { EnterConfirmationCodeView() })
        }
        .navigationBarBackButtonHidden(true)
        .environmentObject(vm)
    }
}

@available(iOS 16.0, *)
struct EnterEmailView_Previews: PreviewProvider {
    static var vm = SignUpViewModel()
    static var previews: some View {
        EnterEmailView(vm: vm)
    }
}
