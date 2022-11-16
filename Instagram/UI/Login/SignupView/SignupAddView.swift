import SwiftUI

struct SignupAddView: View {
    
    @ObservedObject var vm: SignupAddViewModel
    @EnvironmentObject var vmSignup: SignupViewModel
    @EnvironmentObject var sessionVm: SessionViewModel
    
    @State private var _selectedIndex: Int = 1
    @State private var _selectedDate: Date = Date.now
    
    @State private var _isShowAge: Bool = false
    @State private var _isSavePassword: Bool = true
    @State private var _isShareThisPhoto: Bool = true
    @State private var _isShowImagePicker: Bool = false
    @State private var _isShowImagePickerOptions: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    
    @Binding var text: String
    @Binding var isNavigation: Bool
    
    var body: some View {
        VStack {
            VStack {
                if vm.type == .add_email {
                    addEmailView()
                }
                else if vm.type == .add_birthday {
                    addYourBirthdayView()
                }
                else if vm.type == .signup_account {
                    signupAccountView()
                }
                else if (vm.type == .find_friend || vm.type == .add_photo) {
                    connectView()
                }
                else if (vm.type == .share_photo) {
                    sharePhotoView()
                } else {
                    otherView()
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            
            if vm.type == .add_birthday {
                withAnimation(.spring(response: 0.5, dampingFraction: 4, blendDuration: 2)) {
                    addYourBirthdayView_Ext()
                }
                    
//                    .transition(.move(edge: .bottom))
//                    .animation(.easeInOut(duration: 0.5))
            } else if vm.type == .signup_account {
                signupAccountView_Ext()
            } else if (vm.type == .find_friend || vm.type == .add_photo) {
                connectView_Ext()
            }
        }
        .alert(isPresented: $vmSignup.isShowAlert, content: {
            Alert(title: Text(vmSignup.alertTitle),
                  message: Text(vmSignup.alertMessage),
                  dismissButton: .default(Text(vmSignup.alertButtonTitle)))
        })
        .overlay {
            ActionSheetCustom(isShowImagePicker: $_isShowImagePicker, isShowImagePickerOptions: $_isShowImagePickerOptions, sourceType: $sourceType)
        }
        .fullScreenCover(isPresented: $_isShowImagePicker, onDismiss: isNavigation_On) {
            ImagePicker(image: $vmSignup.avatarImage,
                        sourceType: self.sourceType)
        }
    }
}

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
                vmSignup.validateEmailFormat { result in
                    if result {
                        vmSignup.validateAccountExist { result, error  in
                            if let error = error {
                                vmSignup.isShowAlert = true
                                vmSignup.alertTitle = "Signup account"
                                vmSignup.alertButtonTitle = "Got it!"
                                vmSignup.alertMessage = error.localizedDescription
                            } else if result {
                                vmSignup.isShowAlert = true
                                vmSignup.alertTitle = "Signup account"
                                vmSignup.alertButtonTitle = "Got it!"
                                vmSignup.alertMessage = "You already have an Instagram account with this email!"
                            } else {
                                isNavigation = true
                            }
                        }
                    } else {
                        vmSignup.isShowAlert = true
                        vmSignup.alertTitle = "Signup account"
                        vmSignup.alertButtonTitle = "Got it!"
                        vmSignup.alertMessage = "Invalid email address!"
                    }
                }
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
            Image(systemName: vm.imageSystemName ?? "")
                .font(.system(size: 100, weight: .ultraLight))
                .foregroundStyle(
                    AngularGradient(colors: [.purple, .red, .yellow, .purple], center: .bottomTrailing, startAngle: .degrees(180), endAngle: .degrees(270))
                )
            
            Text(vm.headerTitle)
                .font(.sfProTextBold(22, relativeTo: .largeTitle))
            
            VStack(spacing: 5) {
                Text(vm.description)
                    .foregroundColor(Color.black.opacity(0.8))
                
                Text(.init(vm.actionText ?? ""))
            }
            .font(.sfProTextRegular(15, relativeTo: .caption1))
            .lineSpacing(3)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(setDateString(selectedDate: _selectedDate))
                        .font(.sfProTextRegular(15, relativeTo: .caption1))
                        .foregroundColor(Color.black.opacity(_isShowAge ? 1 : 0.5))
                    
                    Spacer()
                    
                    if _isShowAge {
                        Text(String(_selectedDate.age) + (vm.textfieldTitle ?? ""))
                            .font(.sfProTextRegular(13, relativeTo: .caption1))
                            .foregroundColor((_isShowAge && _selectedDate.age < 5) ? Color.red : Color.black.opacity(0.5))
                    }
                }
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.blue.opacity(0.5), lineWidth: 0.5)
                }
                .background {
                    Color.white
                }
                .cornerRadius(5)
                
                if (_isShowAge && _selectedDate.age < 5) {
                    Text(vm.questionText ?? "")
                        .font(.sfProTextRegular(13, relativeTo: .caption1))
                        .foregroundColor(Color.black.opacity(0.5))
                }
            }
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
                    if _selectedDate.age < 5 {
                        vmSignup.isShowAlert = true
                        vmSignup.alertTitle = "Enter your real birthday"
                        vmSignup.alertButtonTitle = "OK"
                        vmSignup.alertMessage = "Use your own birthday, even if this account is for a business, a pet or something else."
                    } else {
                        isNavigation = true
                    }
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
            Text(vm.headerTitle +  vmSignup.username + " ?")
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
        VStack(spacing: 20) {
            Divider()
            Button {
                isNavigation = true
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
                    .font(.system(size: 120, weight: .ultraLight))
                    .foregroundStyle(
                        AngularGradient(colors: [.purple, .red, .yellow, .purple], center: .bottomTrailing, startAngle: .degrees(180), endAngle: .degrees(270))
                    )
                    .offset(y: -70)
                
                Spacer()
            }
        }
    }
    
    private func connectView_Ext() -> some View {
        VStack(spacing: 20) {
            Divider()
            Group {
                Button {
                    if vm.type == .add_photo {
                        withAnimation {
                            _isShowImagePickerOptions = true
                        }
                    } else {
                        vmSignup.isShowAlert = true
                        vmSignup.alertTitle = "Find facebook friends"
                        vmSignup.alertButtonTitle = "OK"
                        vmSignup.alertMessage = "This func un-implement!"
                    }
                } label: {
                    Text(vm.buttonLable)
                }
                .buttonStyle(CustomButtonStyle())
                
                Button {
                    isNavigation = true
                } label: {
                    Text(vm.actionText ?? "")
                        .font(.sfProTextBold(16, relativeTo: .caption1))
                }
                .padding(.bottom, 5)
            }
            .padding(.horizontal)
        }
    }
    
    private func sharePhotoView() -> some View {
        VStack(spacing: 20) {
            
            ZStack {
                if let image = vmSignup.avatarImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: vm.imageSystemName ?? "")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: 90, height: 90)
            .cornerRadius(45)
            .overlay(
                Circle()
                    .stroke(LinearGradient(
                        colors: [.red, .purple, .red, .orange, .yellow, .orange],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing),
                            lineWidth: 3)
                    .frame(width: 100, height: 100)
            )
            .padding(.top, 50)
            
            Text(vm.headerTitle)
                .font(.sfProTextBold(22, relativeTo: .largeTitle))
                .padding(.top, 20)
            
            Button {
                withAnimation {
                    _isShowImagePickerOptions = true
                }
            } label: {
                Text(vm.actionText ?? "")
                    .font(.sfProTextSemibold(15, relativeTo: .caption1))
                    .foregroundColor(Color.blue)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Toggle(vm.questionText ?? "", isOn: $_isShareThisPhoto.animation(.spring()))
                    .font(.sfProTextRegular(15, relativeTo: .caption1))
                    .foregroundColor(Color.black.opacity(0.6))
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(vm.description)
                    .font(.sfProTextRegular(12, relativeTo: .caption1))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.black.opacity(0.5))
            }
            
            Button {
                vmSignup.signupAccount { user in
                    self.sessionVm.userInfo = user
                    LocalStorage.store(with: user, forKey: StorageKey.USER_INFO)
                    isNavigation = true
                }
            } label: {
                Text(vm.buttonLable)
            }
            .buttonStyle(CustomButtonStyle())
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
                isNavigation = true
            } label: {
                Text(vm.buttonLable)
            }
            .buttonStyle(CustomButtonStyle())
            .opacity(vm.type == .add_password ? (text.count < 6 ? 0.5 : 1) : (text.isEmpty ? 0.5 : 1))
            .disabled(vm.type == .add_password ? (text.count < 6) : (text.isEmpty))
        }
    }
    
    private func savePasswordView() -> some View {
        HStack(alignment: .center, spacing: 5) {
            Button {
                self._isSavePassword.toggle()
            } label: {
                Image(systemName: (_isSavePassword ? vm.imageSystemName : vm.imageSystemName_ext) ?? "")
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

extension SignupAddView {
    ///Use in addYourBirthdayView()
    private func setDateString(selectedDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: selectedDate)
    }
    
    private func isNavigation_On() {
        ///Auto next view apply for AddPhotoView only, not SharePhotoView
        ///vmSignup.avatarImage != nil to check case that user press cancel ImagePickerView
        if (vm.type == .add_photo && vmSignup.avatarImage != nil) {
            withAnimation {
                isNavigation = true
            }
        }
    }
}

extension Date {
    ///Use in addYourBirthdayView()
    var age: Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
}
