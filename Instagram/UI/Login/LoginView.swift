import SwiftUI

struct LoginView: View {
    
    @StateObject var vm = LoginViewModel()
    @State private var _isHidePassword: Bool = true
    
    var body: some View {
        VStack(spacing: 30) {
            Group {
                Spacer()
                Image.imgInstagramLogo
                    .resizable()
                    .frame(width: 182, height: 49)
                    .padding(.bottom, 30)
                
                VStack(spacing: 18) {
                    TextField(vm.emailTitle, text: $vm.email)
                        .textFieldStyle(CustomTextFieldStyle())
                    
                    passwordTextField()
                    forgotPassword()
                        .padding(.top,5)
                }
                
                Button {
                    vm.handleLogin()
                } label: {
                    Text(vm.loginButtonTitle)
                }
                .buttonStyle(CustomButtonStyle())
                .opacity(vm.textFieldIsEmpty() ? 0.5 : 1)
                .disabled(vm.textFieldIsEmpty())
                
                optionLogin()
                Spacer()
            }
            .padding(.horizontal, 25)
            
            BottomBarView(
                questionText: vm.questionText,
                actionText: vm.actionText) {
                    withAnimation {
                        vm.isShowSignUpView = true
                    }
                }
        }
        .overlay {
            if vm.isShowResetPasswordView {
                ResetPasswordView()
                    .transition(.move(edge: .trailing))
            }

            if vm.isShowSignUpView {
                SignUpView()
                    .transition(.move(edge: .trailing))
            }
        }
        .environmentObject(vm)
    }
}

extension LoginView {
    
    private func passwordTextField() -> some View {
        ZStack {
            if _isHidePassword {
                SecureField(vm.passwordTitle, text: $vm.password)
            } else {
                TextField(vm.passwordTitle, text: $vm.password)
            }
        }
        .textFieldStyle(CustomTextFieldStyle())
        .overlay (
            Button {
                withAnimation {
                    _isHidePassword.toggle()
                }
            } label: {
                Image(systemName: self._isHidePassword ? "eye.slash.fill" : "eye")
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
            ,alignment: .trailing
        )
    }
    
    private func forgotPassword() -> some View {
        HStack {
            Spacer()
            Text(vm.forgotPasswordText)
                .font(.sfProTextSemibold(13, relativeTo: .caption1))
                .foregroundColor(Color.blue)
                .onTapGesture {
                    withAnimation {
                        vm.isShowResetPasswordView = true
                    }
                }
        }
    }
    
    private func optionLogin() -> some View {
        VStack(spacing: 40) {
            DivideView()
            FacebookLoginView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
