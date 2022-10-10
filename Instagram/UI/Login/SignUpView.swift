import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var vm: LoginViewModel
    @Environment(\.presentationMode) var presentationMode
    
    private let titles: [String] = ["Phone", "Email"]
    @State var selectedIndex: Int = 1
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Group {
                    Text("Enter Phone or Email")
                        .font(.sfProTextBold(25, relativeTo: .largeTitle))
                    
                    SegmentedPickerView(titles: titles, selectedIndex: $selectedIndex)
                    
                    if selectedIndex == 0 {
                        PhoneTextFieldView()
                    } else {
                        emailTextField()
                    }
                    
                    nextButton()
                    
                    if selectedIndex == 0 {
                        Text("You may receive SMS notification from us for security and login purposes.")
                            .font(.sfProTextRegular(14, relativeTo: .title1))
                            .foregroundColor(Color.black.opacity(0.5))
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                }
                .padding(.horizontal, 15)
                
                tabbar()
            }
            .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image.icnBack
                .frame(width: 24, height: 24)
        }))
    }
}

extension SignUpView {
    
    private func emailTextField() -> some View {
        TextField("Email Address", text: $vm.email)
            .textFieldStyle(CustomTextFieldStyle())
    }
    
    private func nextButton() -> some View {
        Button {
            
        } label: {
            Text("Next")
        }
        .buttonStyle(CustomButtonStyle())
        .opacity(vm.email.isEmpty ? 0.5 : 1)
        .disabled(vm.email.isEmpty)
    }
    
    private func tabbar() -> some View {
        VStack(spacing: 18) {
            Divider()
            QuestionTextButtonView(
                questionText: "Already have an account?",
                actionText: "Sign In.") {
                    presentationMode.wrappedValue.dismiss()
                }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(LoginViewModel())
    }
}
