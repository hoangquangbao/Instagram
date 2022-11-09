import SwiftUI
import FirebaseFirestore

struct LoginView: View {
    
    @EnvironmentObject var vm: LoginViewModel
    @EnvironmentObject var perform: BackLoginViewModel
    @EnvironmentObject var sessionVm: SessionViewModel
    
    @State private var _isHidePassword: Bool = true
    @State var _isNavigation: Int? = nil
    
    var userService = UserService()
    
    var body: some View {
        NavigationView {
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
                        vm.handleLogin { uid in
                            self.userService.get(by: uid) { user in
                                self.sessionVm.userInfo = user
                                LocalStorage.store(with: user, forKey: StorageKey.USER_INFO)
                                
                            }
                        }
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
                
                bottomBarView()
                
                NavigationLink(destination: TabbarBottomView(), isActive:
                                $perform.isBackLoginView
                ) { EmptyView() }
            }
            .onChange(of: vm.isShowTabbarBottomView) { result in
                perform.isBackLoginView = result
            }
            .overlay {
                if vm.isShowResetPasswordView {
                    ResetPasswordView()
                        .transition(.move(edge: .trailing))
                }
            }
            .alert(isPresented: $vm.isShowAlert, content: {
                Alert(title: Text(vm.alertTitle),
                      message: Text(vm.alertMessage),
                      dismissButton: .default(Text(vm.alertButtonTitle)))
            })
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

extension LoginView {
    
    private func passwordTextField() -> some View {
        HStack {
            ZStack {
                if _isHidePassword {
                    SecureField(vm.passwordTitle, text: $vm.password)
                } else {
                    TextField(vm.passwordTitle, text: $vm.password)
                }
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    _isHidePassword.toggle()
                }
            } label: {
                Image(systemName: self._isHidePassword ? "eye.slash.fill" : "eye")
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
        }
        .font(.sfProTextRegular(15, relativeTo: .caption1))
        .foregroundColor(Color.black)
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
        .cornerRadius(5)
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
    
    private func bottomBarView() -> some View {
        VStack(spacing: 30) {
            Divider()
            HStack(alignment: .center, spacing: 4) {
                Text(vm.questionText)
                    .font(.sfProTextRegular(13, relativeTo: .caption1))
                    .foregroundColor(Color.black.opacity(0.5))
                
                NavigationLink(destination: AddEmailView(),
                               isActive: self.$perform.isBackLoginView_ext) {
                    Text(vm.actionText)
                        .font(.sfProTextSemibold(13, relativeTo: .caption1))
                        .foregroundColor(Color.blue)
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
