import SwiftUI

struct EditProfileView: View {
    
    @EnvironmentObject var vm: ProfileViewModel
    @EnvironmentObject var userVm: UserViewModel
    let user: User
    
    @State private var _isShowImagePicker: Bool = false
    @State private var _isShowImagePickerOptions: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                _userAvatar
                VStack {
                    
                }
            }
            .overlay {
                ActionSheetCustom(isShowImagePicker: $_isShowImagePicker, isShowImagePickerOptions: $_isShowImagePickerOptions, sourceType: $sourceType)
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
                            sourceType: self.sourceType)
            })
            .toolbar {
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

//struct EditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileView()
//    }
//}

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
