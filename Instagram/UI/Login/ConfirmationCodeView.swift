import SwiftUI

struct ConfirmationCodeView: View {
    
    @StateObject var vm: SignUpViewModel = Signup(onScreen: .add_confirmation_code).signUpViewModel
    @EnvironmentObject var vmSignUp: SignUpViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                backButton()
                Group {
                    Text(vm.headerTitle)
                        .font(.sfProTextBold(22, relativeTo: .largeTitle))
                    
                    HStack {
                        Text(vm.description)
                        +
                        Text("\(vmSignUp.email).")
                        +
                        //On-hold handle action for this text
                        Text(vm.actionText ?? "")
                            .font(.sfProTextBold(14, relativeTo: .caption1))
                            .foregroundColor(.blue)
                    }
                    .font(.sfProTextRegular(14, relativeTo: .caption1))
                    .foregroundColor(Color.black.opacity(0.8))
                    .lineSpacing(3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    TextField(vm.textFieldTitle, text: $vm.code)
                        .textFieldStyle(CustomTextFieldStyle())
                    
                    Button {
                        withAnimation {
                            vm.isShowAddYourNameView = true
                        }
                    } label: {
                        Text(vm.nextButtonTitle)
                    }
                    .buttonStyle(CustomButtonStyle())
                    .opacity(vm.code.isEmpty ? 0.5 : 1)
                    .disabled(vm.code.isEmpty)
                    
                    Spacer()
                }
                .padding(.horizontal, 30)
            }
            .background()
            .overlay(content: {
                if vm.isShowAddYourNameView ?? false {
                    AddYourNameView()
                        .transition(.move(edge: .trailing))
                }
            })
        }
    }
}

extension ConfirmationCodeView {
    private func backButton() -> some View {
        HStack {
            Button {
                withAnimation {
                    vmSignUp.isShowConfirmationCodeView = false
                }
            } label: {
                Image.icnBack
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.bottom, -15)
    }
}

struct ConfirmationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationCodeView()
    }
}
