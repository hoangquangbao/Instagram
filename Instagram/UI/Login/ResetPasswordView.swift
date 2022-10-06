import SwiftUI

struct ResetPasswordView: View {
    
    @EnvironmentObject var vm: LoginViewModel
    @Environment(\.presentationMode) var presentationMode
    
    private let titles: [String] = ["Username", "Phone"]
    @State var selectedIndex: Int = 0
    @State var isAccountExist: Bool = true
    @State var alertText: String = ""
    @FocusState private var isFocusedKeyboard: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Group {
                    Image(systemName: "lock")
                        .font(.system(size: 45))
                        .padding(15)
                        .background (
                            Circle()
                                .stroke(.black, lineWidth: 2)
                        )
                        .padding(.top, 20)
                    
                    Text("Trouble logging in?")
                        .font(.sfProTextSemibold(20, relativeTo: .largeTitle))
                    
                    pickerView()
                    
                    if selectedIndex == 0 {
                        emailTextField()
                    } else {
                        PhoneTextFieldView()
                    }
                    
                    nextButton()
                    optionLogin()
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                tabbar()
            }
            .edgesIgnoringSafeArea(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension ResetPasswordView {
    
    private func pickerView() -> some View {
        VStack {
            Group {
                if selectedIndex == 0 {
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
            .fixedSize(horizontal: false, vertical: true)
            
            SegmentedPickerView(titles: titles, selectedIndex: $selectedIndex)
        }
    }
    
    private func emailTextField() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField("Username or email", text: $vm.email, onEditingChanged: { editing in
                if editing {
                    withAnimation {
                        isAccountExist = true
                    }
                }
            })
            .textFieldStyle(CustomTextFieldStyle())
            .focused($isFocusedKeyboard)
            .overlay {
                RoundedRectangle(cornerRadius: 5).stroke(isAccountExist ? Color.black.opacity(0.5) : Color.red, lineWidth: 0.5)
            }
            
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
                        vm.handleResetPassword()
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
        }
        .buttonStyle(CustomButtonStyle())
        .opacity((vm.email.isEmpty||selectedIndex == 1) ? 0.5 : 1)
        .disabled(vm.email.isEmpty||selectedIndex == 1)
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
            QuestionTextButtonView(
                questionText: "",
                actionText: "Back to log in") {
                    presentationMode.wrappedValue.dismiss()
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
