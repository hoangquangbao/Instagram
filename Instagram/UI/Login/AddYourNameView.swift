import SwiftUI

struct AddYourNameView: View {
    
    @StateObject var vm: SignUpViewModel = Signup(onScreen: .add_name).signUpViewModel
    @EnvironmentObject var vmLogin: LoginViewModel
    @EnvironmentObject var vmSignUp: SignUpViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Group {
                    Text(vm.headerTitle)
                        .font(.sfProTextBold(22, relativeTo: .largeTitle))
                    
                    Text(vm.description)
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

                BottomBarView(
                    questionText: vm.questionText,
                    actionText: vm.actionText ?? "") {
                        withAnimation {
                        }
                    }
            }
        }
    }
}

struct AddYourNameView_Previews: PreviewProvider {
    static var previews: some View {
        AddYourNameView()
    }
}
