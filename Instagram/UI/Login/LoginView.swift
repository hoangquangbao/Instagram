import SwiftUI

struct LoginView: View {
    
    @StateObject var vm = LoginViewModel()
    @State var isHidePassword: Bool = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Group {
                    Spacer()
                    Image.imgInstagramLogo
                        .resizable()
                        .frame(width: 182, height: 49)
                        .padding(.bottom, 40)
                    
                    VStack(spacing: 18) {
                        emailTextField()
                        passwordTextField()
                        forgotPassword()
                            .padding(.top,5)
                    }
                    loginButton()
                    optionLogin()
                    Spacer()
                }
                .padding(.horizontal, 20)

                tabbar()
            }
            .edgesIgnoringSafeArea(.horizontal)
        }
        .environmentObject(vm)
    }
}

extension LoginView {
    
    private func emailTextField() -> some View {
        TextField("Email Address", text: $vm.email, onEditingChanged: { editing in
            if !editing {
                if !vm.validateEmailFormat() && !vm.email.isEmpty {
                    print("Email is incorrect format!")
                }
            }
        })
        .textFieldStyle(CustomTextFieldStyle())
    }
    
    private func passwordTextField() -> some View {
        ZStack {
            if isHidePassword {
                SecureField("Password", text: $vm.password)
            } else {
                TextField("Password", text: $vm.password)
            }
        }
        .textFieldStyle(CustomTextFieldStyle())
        .overlay (
            Button {
                withAnimation {
                    isHidePassword.toggle()
                }
            } label: {
                Image(systemName: self.isHidePassword ? "eye.slash.fill" : "eye")
                    .accentColor(.gray)
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
            ,alignment: .trailing
        )
    }
    
    private func forgotPassword() -> some View {
        HStack {
            Spacer()
            NavigationLink(destination: ResetPasswordView()) {
                Text("Forgot password?")
                    .font(.sfProTextSemibold(12, relativeTo: .caption1))
                    .foregroundColor(Color.blue)
            }
        }
    }
    
    private func loginButton() -> some View {
        Button {
            vm.handleLogin()
        } label: {
            Text("Log in")
        }
        .buttonStyle(CustomButtonStyle())
        .opacity(vm.textFieldIsEmpty() ? 0.5 : 1)
        .disabled(vm.textFieldIsEmpty())
    }
    
    private func optionLogin() -> some View {
        VStack(spacing: 40) {
            DivideView()
            ImageTextButtonView(
                icon: Image.icnFacebook,
                text: "Log in with Facebook") {
                    print("Not implemented yet!")
                }
                .font(.sfProTextSemibold(14, relativeTo: .title1))
                .foregroundColor(Color.blue)
        }
    }
    
    private func tabbar() -> some View {
        VStack(spacing: 18) {
            Divider()
            QuestionTextButtonView(
                questionText: "Don't have an account?",
                actionText: "Sign up.") {
                    vm.resetTextField()
                }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
