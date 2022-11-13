import SwiftUI

struct EditProfileView: View {
    let user: User
    @EnvironmentObject var vm: ProfileViewModel
    @EnvironmentObject var userVm: UserViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var _isShowImagePicker: Bool = false
    @State private var _isShowImagePickerOptions: Bool = false
    @State private var _sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var _selectedItem: EditProfile? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                _userAvatar
                _editProfile
            }
            .overlay {
                ActionSheetCustom(isShowImagePicker: $_isShowImagePicker, isShowImagePickerOptions: $_isShowImagePickerOptions, sourceType: $_sourceType)
            }
            .fullScreenCover(isPresented: $_isShowImagePicker, onDismiss: {
                vm._uploadAvatar { isSuccess, error in
                    if isSuccess {
                        dismiss()
                        userVm.refresh()
                    } else {
                        print(error?.localizedDescription as Any)
                    }
                }
            }, content: {
                ImagePicker(image: $vm.imageAttach,
                            sourceType: self._sourceType)
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Edit profile")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.appPrimary)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .font(.system(size: 25, weight: .regular))
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

private extension EditProfileView {
    var _userAvatar: some View {
        ZStack{
            CircleAvatar(imageUrl: user.avatarUrl, radius: 90)
            
            ZStack{
                Circle()
                    .fill(Color.blue)
                    .frame(width: 25, height: 25)
                
                Image(systemName: "plus")
                    .font(Font.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                
                Circle().stroke(Color.white, lineWidth: 2)
                    .frame(width: 25, height: 25)
            }
            .offset(x: 35, y: 30)
        }
        .onTapGesture {
            withAnimation {
                _isShowImagePickerOptions = true
            }
        }
    }
}

private extension EditProfileView {
    var _editProfile: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                ForEach(EditProfileData) { item in
                    Button {
                        _selectedItem = item
                    } label: {
                        _field(item: item)
                    }
                }
            }
            .sheet(item: $_selectedItem) { item in
                EditFieldView()
            }
        }
    }
    
    func _field(item: EditProfile) -> some View {
        VStack(spacing: 3) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.title)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.semiText)
                    Text(vm.getFieldKeyPath(key: item.title).map { user[keyPath: $0] } ?? "Unknown")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(Color.appPrimary)
                }
                Spacer(minLength: 0)
            }
            Divider()
        }
        .padding(.horizontal)
    }
}
