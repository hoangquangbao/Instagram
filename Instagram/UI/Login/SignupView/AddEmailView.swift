import SwiftUI

@available(iOS 16.0, *)
struct AddEmailView: View {
    
    @StateObject var vm = SignupViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var _isNavigation: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                SignupAddView(vm: vm.addEmailVM,
                              text: $vm.email,
                              isNavigation: $_isNavigation)
                
                Divider()
                    .padding(.bottom, 10)
                
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
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
            }
            .navigationDestination(isPresented: $_isNavigation,
                                   destination: { AddConfirmationCodeView() })
        }
        .navigationBarBackButtonHidden(true)
        .environmentObject(vm)
    }
}

@available(iOS 16.0, *)
struct AddEmailView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmailView()
            .environmentObject(SignupViewModel())
    }
}
