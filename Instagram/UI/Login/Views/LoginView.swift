import SwiftUI

struct LoginView: View {
    
    @StateObject var vm = LoginViewModel()
    @State var isHidePassword: Bool = true
    @State var isSignIn: Bool = true
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 30) {
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
                signUpInButton()
                optionLogin()
                Spacer()
                tabbar()
            }
            .padding(.horizontal, 15)
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
        .keyboardType(.emailAddress)
        .font(.sfProTextMedium(16, relativeTo: .caption2))
        .foregroundColor(Color._262626)
        .padding(.leading)
        .frame(maxWidth: .infinity)
        .frame(height: 45)
        .overlay {
            RoundedRectangle(cornerRadius: 5).stroke(Color.black.opacity(0.5), lineWidth: 0.5)
        }
        .background {
            Color.white
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
        .frame(height: 45)
        .overlay {
            RoundedRectangle(cornerRadius: 5).stroke(Color.black.opacity(0.5), lineWidth: 0.5)
        }
        .background {
            Color.white
        }
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .submitLabel(.done)
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
    
    private func signUpInButton() -> some View {
        Button {
            
            if isSignIn {
                vm.signIn()
            } else {
                vm.signUp()
            }
            
        } label: {
            Text("Log in")
                .font(.sfProTextBold(16, relativeTo: .title1))
                .foregroundColor(.white)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .background(
                    Color.blue
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.7), radius: 2, y: 2)
                )
                .opacity(vm.textFieldIsEmpty() ? 0.5 : 1)
        }
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
