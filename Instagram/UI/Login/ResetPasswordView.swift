import SwiftUI

struct ResetPasswordView: View {
    
    @StateObject var vm = ResetPasswordViewModel()
    @EnvironmentObject var vmLogin: LoginViewModel
    
    @State private var _selectedIndex: Int = 0
    @State private var _isAccountExist: Bool = true
    @State private var _alertText: String = "No users found"
    @FocusState private var _isFocusedKeyboard: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Group {
                Image(systemName: "lock")
                    .font(.system(size: 45))
                    .padding(15)
                    .background (Circle()
                        .stroke(.black, lineWidth: 2))
                    .padding(.top, 20)
                
                Text(vm.headerTitle)
                    .font(.sfProTextSemibold(20, relativeTo: .largeTitle))
                
                pickerView()
                
                if _selectedIndex == 0 {
                    emailTextField()
                } else {
                    PhoneTextFieldView()
                }
                
                nextButton()
                optionLogin()
                Spacer()
            }
            .padding(.horizontal, 30)
            
            BottomBarView(
                questionText: "",
                actionText: vm.actionText) {
                    withAnimation {
                        vmLogin.isShowResetPasswordView = false
                    }
                }
        }
        .background()
    }
}

extension ResetPasswordView {
    
    private func pickerView() -> some View {
        VStack {
            Group {
                if _selectedIndex == 0 {
                    Text(vm.phoneOptionDescription)
                } else {
                    Text(vm.usernameOptionDescription)
                }
            }
            .font(.sfProTextRegular(14, relativeTo: .caption1))
            .foregroundColor(Color.black.opacity(0.8))
            .lineSpacing(3)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 30)
            .fixedSize(horizontal: false, vertical: true)
            
            SegmentedPickerView(
                titles: vm.pickerTitles,
                selectedIndex: $_selectedIndex)
        }
    }
    
    private func emailTextField() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField(vm.emailTitle, text: $vmLogin.email, onEditingChanged: { editing in
                if editing {
                    withAnimation {
                        _isAccountExist = true
                    }
                }
            })
            .textFieldStyle(CustomTextFieldStyle())
            .focused($_isFocusedKeyboard)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(_isAccountExist ? Color.black.opacity(0.5) : Color.red, lineWidth: 0.5)
            }
            
            if !_isAccountExist {
                Text(_alertText)
                    .font(.sfProTextRegular(12, relativeTo: .title1))
                    .foregroundColor(Color.red)
            }
        }
    }
    
    private func nextButton() -> some View {
        Button {
            _isFocusedKeyboard = false
            vm.handleResetPassword(email: vmLogin.email) { result in
                withAnimation {
                    _isAccountExist = result
                }
            }
        } label: {
            Text(vm.nextButtonTitle)
        }
        .buttonStyle(CustomButtonStyle())
        .opacity((vmLogin.email.isEmpty||_selectedIndex == 1) ? 0.5 : 1)
        .disabled(vmLogin.email.isEmpty||_selectedIndex == 1)
    }
    
    private func optionLogin() -> some View {
        VStack(spacing: 40) {
            Button {
                print("Not implemented yet!")
            } label: {
                Text(vm.resetQuestionText)
                    .font(.sfProTextRegular(12, relativeTo: .caption1))
            }
            
            DivideView()
            FacebookLoginView()
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
            .environmentObject(LoginViewModel())
    }
}
