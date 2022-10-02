import SwiftUI

struct LoginHelpView: View {
    
    @EnvironmentObject var vm: LoginViewModel
    @State var isAccountExist: Bool = true
    @State var alertText: String = ""
    @FocusState private var isFocusedKeyboard: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 18) {
                Text("Find your account")
                    .font(.sfProTextBold(20, relativeTo: .largeTitle))
                
                Text("Enter your the email linked to your account")
                    .font(.sfProTextRegular(12, relativeTo: .title1))
                    .foregroundColor(Color._000000.opacity(0.5))
                    .padding(.bottom, 40)
                
                emailTextField()
                nextButton()
                optionLogin()
            }
            .padding(.horizontal, 30)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Text("Login help")
                        .font(.sfProTextSemibold(20, relativeTo: .largeTitle))
                }
            })
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.backward")
                    .font(.sfProTextBold(14, relativeTo: .caption1))
                    .foregroundColor(.black)
            }))
        }
    }
}

extension LoginHelpView {
    
    private func emailTextField() -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            TextField("Email Address", text: $vm.email, onEditingChanged: { editing in
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
            .frame(height: 50)
            .overlay {
                RoundedRectangle(cornerRadius: 5).stroke(isAccountExist ? Color._000000.opacity(0.5) : Color.red, lineWidth: 0.5)
            }
            .background {
                Color.fafafa
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .submitLabel(.done)
            
            if !isAccountExist {
                Text(alertText)
                    .font(.sfProTextRegular(11, relativeTo: .title1))
                    .foregroundColor(Color.red)
            }
        }
    }
    
    private func nextButton() -> some View {
        Button {
            isFocusedKeyboard = false
            if !vm.validateEmailFormat() {
                print("Email is incorrect format!")
            } else {
                withAnimation {
                    vm.validateAccountExist(completion: { result in
                        if !result {
                            withAnimation {
                                isAccountExist = result
                                alertText = "No users found"
                            }
                        }
                    })
                }
            }
        } label: {
            Text("Next")
                .font(.sfProTextSemibold(16, relativeTo: .title1))
                .foregroundColor(.ffffff)
                .frame(height: 50)
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
        VStack(spacing: 18) {
            DivideView()
            ImageTextButtonView(
                icon: Image.icnFacebook,
                text: "Log in with Facebook") {
                    print("Connect Facebook")
                }
                .font(.sfProTextSemibold(16, relativeTo: .title1))
                .foregroundColor(Color._000000)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background {
                    Color.gray
                        .opacity(0.2)
                        .cornerRadius(10)
                }
        }
    }
}

struct LoginHelpView_Previews: PreviewProvider {
    static var previews: some View {
        LoginHelpView()
    }
}
