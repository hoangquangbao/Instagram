import SwiftUI

struct LoginView: View {
    
    @StateObject var vm = LoginViewModel()
    @State var isHidePassword: Bool = true
    @State var isSignIn: Bool = true
    
    var body: some View {
        
        VStack(spacing: 18) {
            
            Group {
                Spacer()
                Image.imgInstagramLogo
                    .resizable()
                    .frame(width: 182, height: 49)
                    .padding(.bottom, 40)
                
                emailTextFiled()
                passwordTextField()
                signUpInButton()
            }

            if isSignIn {
                QuestionTextButtonView(
                    questionText: "Forgot your login details?",
                    actionText: "Get help logging in.") {
                        print("Naviga ResetPasswordView")
                    }
            }
            
            DivideView()
            loginFacebook()
            
            Spacer()
            
            Divider()
            QuestionTextButtonView(
                questionText: isSignIn ? "Don't have an account?" : "Already have an account?",
                actionText: isSignIn ? "Sign up." : "Log in.") {
                    isSignIn.toggle()
                }
                .padding(.top, 18)
        }
        .padding(.horizontal, 15)
        .environmentObject(vm)
    }
}

extension LoginView {
    
    private func emailTextFiled() -> some View {
        TextField("Email Address", text: $vm.email, onEditingChanged: { editing in
            if !editing {
                if !vm.validateEmail(vm.email) {
                    print("Email is incorrect format!")
                }
            }
        })
        .keyboardType(.emailAddress)
        .font(.sfProTextMedium(14, relativeTo: .caption2))
        .foregroundColor(Color._262626)
        .padding(.leading)
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .overlay {
            RoundedRectangle(cornerRadius: 5).stroke(Color._000000.opacity(0.1), lineWidth: 0.5)
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
                isHidePassword.toggle()
            } label: {
                Image(systemName: self.isHidePassword ? "eye.slash.fill" : "eye")
                    .accentColor(.gray)
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
        }
        .font(.sfProTextMedium(14, relativeTo: .caption2))
        .foregroundColor(Color._262626)
        .padding(.leading)
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .overlay {
            RoundedRectangle(cornerRadius: 5).stroke(Color._000000.opacity(0.1), lineWidth: 0.5)
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
                .font(.sfProTextSemibold(14, relativeTo: .title1))
                .foregroundColor(.ffffff)
                
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(
                    Color._3797Ef
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.7), radius: 2, y: 3)
                )
                .opacity(vm.textFieldIsEmpty() ? 0.5 : 1)
        }
        .disabled(vm.textFieldIsEmpty())
    }
    
    private func loginFacebook() -> some View {
        Button {
            print("Connect Facebook")
        } label: {
            HStack {
                Image.iconFacebook
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text("Log in with Facebook")
                    .font(.sfProTextSemibold(14, relativeTo: .title1))
                    .foregroundColor(Color._3797Ef)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
