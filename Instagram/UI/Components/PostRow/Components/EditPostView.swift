import SwiftUI

struct EditPostView: View {
    
    @ObservedObject var vm: PostRowViewModel
    
    @State private var _caption: String = ""
    @State private var _imagesUrl: [String] = []
    @State private var _fields: [String] = []
    @State private var _imageSelectionIndex = 0
    @State private var _isLoading: Bool = false
    
    @EnvironmentObject var userVm: UserViewModel
    @EnvironmentObject var postVm: PostViewModel
    @Environment(\.dismiss) var dismiss
    
    init(post: Post) {
        self.vm = PostRowViewModel(post: post)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                _header
                _postInfo
                
                Spacer()
            }
            .onAppear(perform: {
                _caption = vm.post.caption
                _imagesUrl = vm.post.imagesUrl
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Edit info")
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
                        vm.handleEditPost(_caption: _caption, _imagesUrl: _imagesUrl) { isSuccess, error in
                            _isLoading.toggle()
                            if isSuccess {
                                Task {
                                    await userVm.refresh()
                                    await postVm.refresh()
                                    _isLoading.toggle()
                                    dismiss()
                                }
                            } else {
                                _isLoading.toggle()
                                dismiss()
                            }
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 25, weight: .regular))
                            .foregroundColor(.blue)
                    }
                    .disabled(_caption.isEmpty || _imagesUrl.isEmpty)
                    .opacity((_caption.isEmpty || _imagesUrl.isEmpty) ? 0.3 : 1)
                }
            }
            .showWaitingDialog(title: "Uploading...", isLoading: $_isLoading)
        }
    }
}

private extension EditPostView {
    
    var _header: some View {
        HStack {
            HStack(spacing: 9.0) {
                CircleAvatar(imageUrl: vm.post.user!.avatarUrl, radius: 40)
                VStack(alignment: .leading) {
                    Text(vm.post.user!.fullName)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text("@\(vm.post.user!.username)")
                        .font(.caption)
                        .fontWeight(.light)
                }
            }
            Spacer()
            _postTime
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.bottom, 8)
    }
    
    var _postTime: some View {
        Text(vm.post.getTimePostAgo())
            .font(.system(.caption))
            .foregroundColor(Color.semiText)
            .padding(.horizontal, AppStyle.defaultSpacing)
            .padding(.top, 5)
    }
    
    var _postInfo: some View {
        VStack {
            if _imagesUrl.isNotEmpty {
                ZStack(alignment: .topLeading) {
                    SquareImageTab(imagesUrl: _imagesUrl, currentStep: $_imageSelectionIndex)
                    
                    Button {
                        _deleteImage(at: _imageSelectionIndex)
                    } label: {
                        Image(systemName: "trash.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.gray.opacity(0.4))
                            .clipShape(Circle())
                            .padding()
                    }
                }
                
                if(vm.imageCount > 1) {
                    ImageTabIndicator(tabCount: vm.imageCount, activeIndex: $_imageSelectionIndex)
                        .padding(.leading, 60)
                }
                
                TextField("", text: $_caption)
                    .font(.footnote)
                    .padding(.top, 8)
                    .padding(.horizontal, AppStyle.defaultSpacing)
            }
        }
    }
}

private extension EditPostView {
    func _deleteImage(at index: Int) {
        if _imagesUrl.count > 0 {
            _imagesUrl.remove(at: index)
        }
    }
}
