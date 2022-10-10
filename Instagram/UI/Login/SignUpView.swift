import SwiftUI

struct SignUpView: View {
    
    @StateObject var vm = SignUpViewModel()
    @EnvironmentObject var vmLogin: LoginViewModel
    
    @State private var _selectedIndex: Int = 1
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
            
                backButton()
                Group {
                    Text(vm.headerTitle)
                        .font(.sfProTextBold(25, relativeTo: .largeTitle))
                    
                    SegmentedPickerView(
                        titles: vm.pickerTitles,
                        selectedIndex: $_selectedIndex)
                    
                    if _selectedIndex == 0 {
                        PhoneTextFieldView()
                    } else {
                        TextField(vm.emailTitle, text: $vm.email)
                            .textFieldStyle(CustomTextFieldStyle())
                    }
                    
                    Button {
                    } label: {
                        Text(vm.nextButtonTitle)
                    }
                    .buttonStyle(CustomButtonStyle())
                    .opacity(vm.email.isEmpty||_selectedIndex == 0 ? 0.5 : 1)
                    .disabled(vm.email.isEmpty||_selectedIndex == 0)
                    
                    if _selectedIndex == 0 {
                        Text(vm.phoneOptionDescription)
                            .font(.sfProTextRegular(13, relativeTo: .title1))
                            .foregroundColor(Color.black.opacity(0.5))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 30)
                
                BottomBarView(questionText: vm.questionText,actionText: vm.actionText) {
                    withAnimation {
                        vmLogin.isShowSignUpView = false
                    }
                }
            }
            .background()
            .environmentObject(vm)
        }
    }
}

extension SignUpView {
    private func backButton() -> some View {
        HStack {
            Button {
                withAnimation {
                    vmLogin.isShowSignUpView = false
                }
            } label: {
                Image.icnBack
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.bottom, -20)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
