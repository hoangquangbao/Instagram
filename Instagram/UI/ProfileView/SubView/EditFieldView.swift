import SwiftUI

struct EditFieldView: View {
    let user: User
    
    @EnvironmentObject var vm: ProfileViewModel
    @EnvironmentObject var userVm: UserViewModel
    @EnvironmentObject var postVm: PostViewModel
    @EnvironmentObject var storyVm: StoryViewModel
    @EnvironmentObject var sessionVm: SessionViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var _item: EditProfile
    @State private var _fieldValue: String = ""
    @State private var _isStoryUploading: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                _field
            }
            .onAppear(perform: {
                _fieldValue = vm.getFieldKeyPath(key: _item.title).map { user[keyPath: $0] } ?? "Unknown"
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(_item.title)
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm._updateProfile(field: vm.getFieldName(key: _item.title), data: _fieldValue) { isSuccess, error in
                            if isSuccess {
                                Task {
                                    _isStoryUploading.toggle()
                                    dismiss()
                                    await userVm.refresh()
                                    await postVm.refresh()
                                    await storyVm.refresh()
                                    await sessionVm.refresh()
                                }
                            } else {
                                _isStoryUploading.toggle()
                                print(error?.localizedDescription as Any)
                            }
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 25, weight: .regular))
                            .foregroundColor(.blue)
                    }
                    .disabled(_fieldValue.isEmpty && (_item.title != "Bio"))
                    .opacity(_fieldValue.isEmpty && (_item.title != "Bio") ? 0.3 : 1)
                }
            }
            .showWaitingDialog(title: "Uploading...", isLoading: $_isStoryUploading)
        }
    }
}

private extension EditFieldView {
    var _field: some View {
        VStack(spacing: 3) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(_item.title)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.semiText)
                    TextField("", text: $_fieldValue)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(Color.appPrimary)
                }
                Spacer(minLength: 0)
            }
            Divider()
            Spacer()
        }
        .padding(.horizontal)
    }
}
