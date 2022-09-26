import SwiftUI

struct LoginView: View {
    
    @StateObject var vm = LoginViewModel()
    @State var isHidePassword: Bool = true
    @State var isSignIn: Bool = true
    @State var isShowHelpView: Bool = false
    
    var body: some View {
        
        VStack(spacing: 18) {
            
            Group {
                Spacer()
                Image.imgInstagramLogo
                    .resizable()
                    .frame(width: 182, height: 49)
                    .padding(.bottom, 40)
                
                emailTextField()
                passwordTextField()
                signUpInButton()

            }
            optionLogin()
            Spacer()
            tabbar()
        }
        .padding(.horizontal, 15)
        .fullScreenCover(isPresented: $isShowHelpView, content: {
            LoginHelpView()
        })
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
        .keyboardType(.emailAddress)
        .font(.sfProTextMedium(16, relativeTo: .caption2))
        .foregroundColor(Color._262626)
        .padding(.leading)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .overlay {
            RoundedRectangle(cornerRadius: 5).stroke(Color._000000.opacity(0.5), lineWidth: 0.5)
        }
        .background {
            Color.fafafa
        }
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .submitLabel(.done)
    }
    
    private func passwordTextField() -> some View {
        HStack {
            if isHidePassword {
                SecureField("Password", text: $vm.password)
            } else {
                TextField("Password", text: $vm.password)
            }
            
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
        }
        .font(.sfProTextMedium(16, relativeTo: .caption2))
        .foregroundColor(Color._262626)
        .padding(.leading)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .overlay {
            RoundedRectangle(cornerRadius: 5).stroke(Color._000000.opacity(0.5), lineWidth: 0.5)
        }
        .background {
            Color.fafafa
        }
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .submitLabel(.done)
    }
    
    private func signUpInButton() -> some View {
        Button {
            
            if isSignIn {
                vm.signIn()
            } else {
                vm.signUp()
            }
            
        } label: {
            Text(isSignIn ? "Log in" : "Sign up")
                .font(.sfProTextBold(16, relativeTo: .title1))
                .foregroundColor(.ffffff)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(
                    Color._3797Ef
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.7), radius: 2, y: 2)
                )
                .opacity(vm.textFieldIsEmpty() ? 0.5 : 1)
        }
        .disabled(vm.textFieldIsEmpty())
    }
    
    private func optionLogin() -> some View {
        
        VStack(spacing: 18) {
            
            if isSignIn {
                QuestionTextButtonView(
                    questionText: "Forgot your login details?",
                    actionText: "Get help logging in.") {
                        isShowHelpView = true
                    }
            }
            
            DivideView()
            ImageTextButtonView(
                icon: Image.iconFacebook,
                text: "Log in with Facebook") {
                    print("Connect Facebook")
                }
                .font(.sfProTextSemibold(14, relativeTo: .title1))
                .foregroundColor(Color._3797Ef)
        }
    }
    
    private func tabbar() -> some View {
        VStack(spacing: 18) {
            Divider()
            QuestionTextButtonView(
                questionText: isSignIn ? "Don't have an account?" : "Already have an account?",
                actionText: isSignIn ? "Sign up." : "Log in.") {
                    isSignIn.toggle()
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
