import SwiftUI

@available(iOS 16.0, *)
struct SignupAddView: View {
    
    @ObservedObject var vm: SignupAddViewModel
    
    @State private var _selectedIndex: Int = 1
    @State private var _selectedDate: Date = Date.now
    
    @State private var _isShowAge: Bool = false
    @State private var _isSavePassword: Bool = false
    
    @Binding var text: String
    @Binding var isNavigation: Bool
    
    var body: some View {
        VStack {
            VStack {
                if vm.type == .add_email {
                    addEmailView()
                } else if vm.type == .add_birthday {
                    addYourBirthdayView()
                } else if vm.type == .signup_account {
                    signupAccountView()
                } else if (vm.type == .find_friend || vm.type == .add_photo) {
                    connectView()
                } else {
                    otherView()
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            
            if vm.type == .add_birthday {
                addYourBirthdayView_Ext()
            } else if vm.type == .signup_account {
                signupAccountView_Ext()
            } else if (vm.type == .find_friend || vm.type == .add_photo) {
                connectView_Ext()
            }
        }
    }
}

@available(iOS 16.0, *)
extension SignupAddView {
    
    private func addEmailView() -> some View {
        VStack(spacing: 20) {
            Text(vm.headerTitle)
                .font(.sfProTextBold(22, relativeTo: .largeTitle))
            
            SegmentedPickerView(
                titles: vm.pickerTitle ?? [],
                selectedIndex: $_selectedIndex)
            
            if _selectedIndex == 0 {
                PhoneTextFieldView()
            } else {
                TextField(vm.textfieldTitle ?? "", text: $text)
                    .textFieldStyle(CustomTextFieldStyle())
                    .keyboardType(.emailAddress)
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
                    .font(.sfProTextRegular(14, relativeTo: .caption1))
                    .foregroundColor(Color.black.opacity(0.5))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
    private func addYourBirthdayView() -> some View {
        VStack(spacing: 20) {
            Image.imgBirthday
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 160)
            
            Text(vm.headerTitle)
                .font(.sfProTextBold(22, relativeTo: .largeTitle))
            
            VStack(spacing: 5) {
                Text(vm.description)
                    .foregroundColor(Color.black.opacity(0.8))
                
                Text(vm.actionText ?? "")
                    .foregroundColor(Color.blue.opacity(0.8))
                    .onTapGesture {
                        
                    }
            }
            .font(.sfProTextRegular(15, relativeTo: .caption1))
            .lineSpacing(3)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            
            HStack {
                Text(setDateString(selectedDate: _selectedDate))
                    .font(.sfProTextRegular(15, relativeTo: .caption1))
                    .foregroundColor(Color.black.opacity(_isShowAge ? 1 : 0.5))
                
                Spacer()
                
                if _isShowAge {
                    Text(String(_selectedDate.age) + (vm.textfieldTitle ?? ""))
                        .font(.sfProTextRegular(13, relativeTo: .caption1))
                        .foregroundColor(Color.black.opacity(0.5))
                }
            }
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .overlay {
                RoundedRectangle(cornerRadius: 5).stroke(Color.black.opacity(0.5), lineWidth: 0.5)
            }
            .background {
                Color.white
            }
            .cornerRadius(5)
        }
    }
    
    private func addYourBirthdayView_Ext() -> some View {
        VStack {
            Text(vm.description_ext ?? "")
                .font(.sfProTextRegular(13, relativeTo: .caption1))
                .foregroundColor(Color.black.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Divider()
            
            Group {
                Button {
                    isNavigation = vm.action()
                } label: {
                    Text(vm.buttonLable)
                }
                .buttonStyle(CustomButtonStyle())
                
                DatePicker("", selection: $_selectedDate, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding(.top, -30)
                    .padding(.bottom, -120)
                    .scaleEffect(CGSize(width: 0.9, height: 0.9))
                    .onChange(of: _selectedDate) { newValue in
                        _isShowAge = true
                        text = setDateString(selectedDate: _selectedDate)
                    }
            }
            .padding(.horizontal)
        }
    }
    
    private func signupAccountView() -> some View {
        VStack(spacing: 20) {
            Text(vm.headerTitle)
                .font(.sfProTextBold(22, relativeTo: .largeTitle))
                .padding(.top, 50)
            
            Text(vm.description)
                .font(.sfProTextRegular(15, relativeTo: .caption1))
                .foregroundColor(Color.black.opacity(0.8))
                .lineSpacing(3)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            Text(.init(vm.description_ext ?? ""))
                .font(.sfProTextRegular(13, relativeTo: .caption1))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(Color.black.opacity(0.5))
                .tint(.black.opacity(0.5))
        }
        .padding(.horizontal, -15)
    }
    
    private func signupAccountView_Ext() -> some View {
        VStack(spacing: 10) {
            Divider()
            
            Button {
                isNavigation = vm.action()
            } label: {
                Text(vm.buttonLable)
            }
            .buttonStyle(CustomButtonStyle())
            .padding(.horizontal)
        }
    }
    
    private func connectView() -> some View {
        VStack(spacing: 20) {
            Group {
                Text(vm.headerTitle)
                    .font(.sfProTextBold(22, relativeTo: .largeTitle))
                    .padding(.top, 50)
                
                Text(vm.description)
                    .font(.sfProTextRegular(15, relativeTo: .caption1))
                    .foregroundColor(Color.black.opacity(0.8))
                    .lineSpacing(3)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()

                Image(systemName: vm.imageSystemName ?? "")
                    .fontWeight(.ultraLight)
                    .font(.system(size: 120))
                    .foregroundStyle(
                        AngularGradient(colors: [.purple, .red, .yellow, .purple], center: .bottomTrailing, startAngle: .degrees(180), endAngle: .degrees(270))
                    )
                
                Spacer()
            }
        }
    }
    
    private func connectView_Ext() -> some View {
        VStack(spacing: 20) {
            Divider()
            
            Group {
                Button {
                } label: {
                    Text(vm.buttonLable)
                }
                .buttonStyle(CustomButtonStyle())
                
                Button {
                    isNavigation = vm.action()
                } label: {
                    Text(vm.actionText ?? "")
                        .font(.sfProTextBold(16, relativeTo: .caption1))
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func otherView() -> some View {
        VStack(spacing: 20) {
            Text(vm.headerTitle)
                .font(.sfProTextBold(22, relativeTo: .largeTitle))
            
            Text(vm.description)
                .font(.sfProTextRegular(15, relativeTo: .caption1))
                .foregroundColor(Color.black.opacity(0.8))
                .lineSpacing(3)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
            ZStack {
                if vm.type == .add_password {
                    SecureField(vm.textfieldTitle ?? "", text: $text)
                } else {
                    TextField(vm.textfieldTitle ?? "", text: $text)
                }
            }
            .textFieldStyle(CustomTextFieldStyle())
            .keyboardType(vm.type == .add_confirmation_code ? .numberPad : .default)
            
            if vm.type == .add_password {
                savePasswordView()
            }
            
            Button {
                isNavigation = vm.action()
            } label: {
                Text(vm.buttonLable)
            }
            .buttonStyle(CustomButtonStyle())
            .opacity(text.isEmpty ? 0.5 : 1)
            .disabled(text.isEmpty)
        }
    }
    
    private func savePasswordView() -> some View {
        HStack(alignment: .center, spacing: 5) {
            Button {
                self._isSavePassword.toggle()
            } label: {
                Image(systemName: _isSavePassword ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 20, height: 18)
            }
            
            Text(vm.saveTitle ?? "")
                .font(.sfProTextRegular(13, relativeTo: .caption1))
                .foregroundColor(Color.black.opacity(0.6))
            
            Spacer()
        }
    }
}

@available(iOS 16.0, *)
extension SignupAddView {
    
    ///Use in addYourBirthdayView()
    private func setDateString(selectedDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: selectedDate)
    }
}

extension Date {
    ///Use in addYourBirthdayView()
    var age: Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
}
