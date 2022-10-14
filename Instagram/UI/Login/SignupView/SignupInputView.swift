import SwiftUI

struct SignupInputView: View {
    
    @ObservedObject var vm: SignupInputViewModel
    @State private var _selectedIndex: Int = 1
    
    @Binding var text: String
    @Binding var isNavigation: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text(vm.headerTitle)
                .font(.sfProTextBold(22, relativeTo: .largeTitle))
            
            //MARK: add_email screen
            if vm.type == .add_email {
                SegmentedPickerView(
                    titles: vm.pickerTitle ?? [],
                    selectedIndex: $_selectedIndex)
                
                if _selectedIndex == 0 {
                    PhoneTextFieldView()
                } else {
                    TextField(vm.textfieldTitle, text: $text)
                        .textFieldStyle(CustomTextFieldStyle())
                }
                
                Button {
                    isNavigation = vm.action()
                } label: {
                    Text(vm.buttonLable)
                }
                .buttonStyle(CustomButtonStyle())
                .opacity(text.isEmpty||_selectedIndex == 0 ? 0.5 : 1)
                .disabled(text.isEmpty||_selectedIndex == 0)
                
                if _selectedIndex == 0 {
                    Text(vm.description)
                        .font(.sfProTextRegular(13, relativeTo: .title1))
                        .foregroundColor(Color.black.opacity(0.5))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            //MARK: other screen
            else {
                Text(vm.description)
                    .font(.sfProTextRegular(14, relativeTo: .caption1))
                    .foregroundColor(Color.black.opacity(0.8))
                    .lineSpacing(3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .fixedSize(horizontal: false, vertical: true)
                
                TextField(vm.textfieldTitle, text: $text)
                    .textFieldStyle(CustomTextFieldStyle())
                
                Button {
                    isNavigation = vm.action()
                } label: {
                    Text(vm.buttonLable)
                }
                .buttonStyle(CustomButtonStyle())
                .opacity(text.isEmpty ? 0.5 : 1)
                .disabled(text.isEmpty)
            }
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}
