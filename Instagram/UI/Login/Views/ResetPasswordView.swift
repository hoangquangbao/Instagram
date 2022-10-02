import SwiftUI

struct ResetPasswordView: View {
    
    @EnvironmentObject var vm: LoginViewModel
    @State var isAccountExist: Bool = true
    @State var alertText: String = ""
    @State var selection: Bool = true
    @FocusState private var isFocusedKeyboard: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Image(systemName: "lock")
                    .font(.system(size: 45))
                    .padding(15)
                    .background (
                        Circle()
                            .stroke(.black, lineWidth: 2)
                    )
                    .padding(.top, 30)
                
                Text("Trouble logging in?")
                    .font(.sfProTextSemibold(20, relativeTo: .largeTitle))
                
                Group {
                    if selection {
                        Text("Enter your username or email and we'll send you a link to get back into your account.")
                    } else {
                        Text("Enter your phone number and we'll send you a login code to get back into your account.")
                    }
                }
                .font(.sfProTextRegular(14, relativeTo: .caption1))
                .foregroundColor(Color.black.opacity(0.8))
                .lineSpacing(3)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                
                Picker("", selection: $selection) {
                    Text("Username")
                        .tag(true)
                    Text("Phone")
                        .tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                emailTextField()
                nextButton()
                optionLogin()
                Spacer()
                tabbar()
            }
            .padding(.horizontal, 15)
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension ResetPasswordView {
    
    private func emailTextField() -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            TextField("Username or email", text: $vm.email, onEditingChanged: { editing in
                    if editing {
                        withAnimation {
                            isAccountExist = true
                        }
                    }
            })
            .keyboardType(.emailAddress)
            .focused($isFocusedKeyboard)
            .font(.sfProTextMedium(16, relativeTo: .caption2))
            .foregroundColor(Color._262626)
            .padding(.leading)
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .overlay {
                RoundedRectangle(cornerRadius: 5).stroke(isAccountExist ? Color.black.opacity(0.5) : Color.red, lineWidth: 0.5)
            }
            .background {
                Color.white
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .submitLabel(.done)
            
            if !isAccountExist {
                Text(alertText)
                    .font(.sfProTextRegular(12, relativeTo: .title1))
                    .foregroundColor(Color.red)
            }
        }
    }
    
    private func nextButton() -> some View {
        
        Button {
            isFocusedKeyboard = false
            vm.validateAccountExist(completion: { result, error  in
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    if result {
                        FirebaseManager.shared.auth.sendPasswordReset(withEmail: vm.email) { error in
                            
                            print(error?.localizedDescription ?? "Email Link Sent. We sent an email to " + vm.email + " with a link to get back into your account")
                        }
                    } else {
                        withAnimation {
                            isAccountExist = result
                            alertText = "No users found"
                        }
                    }
                }
            })
        } label: {
            Text("Next")
                .font(.sfProTextSemibold(16, relativeTo: .title1))
                .foregroundColor(.white)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .background(
                    Color._3797Ef
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.7), radius: 2, y: 3)
                )
                .opacity(vm.email.isEmpty ? 0.5 : 1)
        }
        .disabled(vm.email.isEmpty)
    }
    
    private func optionLogin() -> some View {
        
        VStack(spacing: 40) {
            
            Button {
                print("Not implemented yet!")
            } label: {
                Text("Can't reset your password?")
                    .font(.sfProTextRegular(12, relativeTo: .caption1))
            }

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
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Back to log in")
                    .font(.sfProTextSemibold(12, relativeTo: .title1))
            }
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
            .environmentObject(LoginViewModel())
    }
}
