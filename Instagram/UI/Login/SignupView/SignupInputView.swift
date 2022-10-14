import SwiftUI

struct SignupInputView: View {
    
    @ObservedObject var vm: SignupInputViewModel
    @State private var _selectedIndex: Int = 1
    @State private var _isSavePassword: Bool = false
    
    @Binding var text: String
    @Binding var isNavigation: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text(vm.headerTitle)
                .font(.sfProTextBold(22, relativeTo: .largeTitle))
            
            if vm.type == .add_email {
                addEmailView()
            } else {
                otherView()
            }
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}

extension SignupInputView {
    
    private func addEmailView() -> some View {
        VStack(spacing: 20) {
            SegmentedPickerView(
                titles: vm.pickerTitle ?? [],
                selectedIndex: $_selectedIndex)
            
            if _selectedIndex == 0 {
                PhoneTextFieldView()
            } else {
                TextField(vm.textfieldTitle, text: $text)
                    .textFieldStyle(CustomTextFieldStyle())
                    .keyboardType(.emailAddress)
            }
            
            Button {
                isNavigation = vm.action()
            } label: {
                Text(vm.buttonLable)
            }
            .buttonStyle(CustomButtonStyle())
            .opacity(text.isEmpty||_selectedIndex == 0 ? 0.5 : 1)
            .disabled(text.isEmpty||_selectedIndex == 0)
            
            if _selectedIndex == 0 {
                Text(vm.description)
                    .font(.sfProTextRegular(13, relativeTo: .title1))
                    .foregroundColor(Color.black.opacity(0.5))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
    private func otherView() -> some View {
        VStack(spacing: 20) {
            Text(vm.description)
                .font(.sfProTextRegular(15, relativeTo: .caption1))
                .foregroundColor(Color.black.opacity(0.6))
                .lineSpacing(3)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
            ZStack {
                if vm.type == .add_password {
                    SecureField(vm.textfieldTitle, text: $text)
                } else {
                    TextField(vm.textfieldTitle, text: $text)
                }
            }
            .textFieldStyle(CustomTextFieldStyle())
            .keyboardType(vm.type == .add_confirmation_code ? .numberPad : .default)
            
            if vm.type == .add_password {
                savePasswordView()
            }
            
            Button {
                isNavigation = vm.action()
            } label: {
                Text(vm.buttonLable)
            }
            .buttonStyle(CustomButtonStyle())
            .opacity(text.isEmpty ? 0.5 : 1)
            .disabled(text.isEmpty)
        }
    }
    
    private func savePasswordView() -> some View {
        HStack(alignment: .center, spacing: 5) {
            Button {
                self._isSavePassword.toggle()
            } label: {
                Image(systemName: _isSavePassword ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 20, height: 18)
            }
            
            Text(vm.saveTitle ?? "")
                .font(.sfProTextRegular(13, relativeTo: .title1))
                .foregroundColor(Color.black.opacity(0.6))
            
            Spacer()
        }
    }
}
