//
//  AddPostView.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//

import SwiftUI

struct NewPostView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userVm: UserViewModel
    @EnvironmentObject var postVm: PostViewModel
    
    @ObservedObject var vm: NewPostViewModel
    
    @State var photosSelected = [UIImage]()
    @State var currentIndex = 0
    @FocusState var hasTextFieldFocus: Bool
    
    init(user: User) {
        vm = NewPostViewModel(user: user)
    }
    
    var body: some View {
        VStack {
            _header
            
            _postInfo
            
            Spacer()
            
            _actionButtonsBuilder
        }
        .showWaitingDialog(title: "Uploading", isLoading: $vm.isUploading)
        .sheet(isPresented: $vm.isBottomSheetDisplay) {
            ImagePicker(image: $vm.imageAttach, sourceType: vm.sourceType)
        }
        .alert("Something was wrong", isPresented: $vm.isErrorAlertDisplay) {
            Button("Try again", role: .cancel) { }
        }
    }
}

private extension NewPostView {
    
    var _header: some View {
        ZStack(alignment: .center) {
            Text("New post")
                .font(.system(size: 18))
                .bold()
            HStack {
                IconButton(imageIcon: Image(systemName: "xmark")) {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.subheadline)
                .foregroundColor(Color._000000)
                
                Spacer()
                
                _uploadButton
            }
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top, 5)
    }
    
    var _uploadButton: some View {
        Button {
            vm.uploadPost { isSuccess in
                if(isSuccess) {
                    vm.isUploading.toggle()
                    userVm.refresh()
                    postVm.refresh()
                    presentationMode.wrappedValue.dismiss()
                } else {
                    vm.isUploading.toggle()
                    vm.isErrorAlertDisplay.toggle()
                }
            }
            
        } label: {
            Text("Upload").font(.subheadline)
        }
        .disabled(vm.caption.isEmpty || vm.imageAttach == nil)
    }
    
    var _postInfo: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ZStack(alignment: .topTrailing) {
                    UserRow(user: vm.user)
                        .padding(.top)
                        .padding(.horizontal, AppStyle.defaultSpacing)
                }
                
                TextEditorWithPlaceholder("What are you thinking about?", text: $vm.caption)
                    .padding(.horizontal, AppStyle.defaultSpacing)
                    .focused($hasTextFieldFocus)
                
                if(photosSelected.count > 0) {
                    SquareImageTab(images: [vm.imageAttach] as! [UIImage], currentStep: $currentIndex)
                }
                
                if let imageAttach = vm.imageAttach {
                    ZStack(alignment: .topTrailing) {
                        SquareImageTab(images: [imageAttach] as! [UIImage], currentStep: $currentIndex)
                        Button {
                            withAnimation {
                                vm.imageAttach = nil
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                }
            }
        } 
    }
    
    var _selectImageButton: some View {
        Button {
            vm.isBottomSheetDisplay.toggle()
            vm.sourceType = .photoLibrary
        } label: {
            HStack {
                Image.icnMultipleSelected
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("Select image")
                    .font(.subheadline)
            }
            .foregroundColor(Color._000000)
            .padding(10)
            .background(Color._3C3C43.opacity(0.8))
            .clipShape(Capsule())
        }
    }
    
    var _openCameraButton: some View {
        Button {
            vm.isBottomSheetDisplay.toggle()
            vm.sourceType = .camera
        } label: {
            Image("icn_camera_bold")
                .renderingMode(.template)
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color.white)
                .padding(10)
                .background(AppStyle.storyLinearGradient)
                .clipShape(Circle())
        }
    }
    
    var _closeKeyboardButton: some View {
        Button {
            
            withAnimation {
                hasTextFieldFocus = false
            }
        } label: {
            Text("Done")
                .font(.subheadline)
                .padding(.vertical, 7)
                .padding(.horizontal)
                .foregroundColor(Color._000000)
                .background(Color._3C3C43.opacity(0.8))
                .cornerRadius(5)
        }
    }
    
}

private extension NewPostView {
    
    @ViewBuilder
    var _actionButtonsBuilder: some View {
        if(hasTextFieldFocus) {
            HStack {
                Spacer()
                _closeKeyboardButton
            }
            .padding(.bottom)
            
            
        } else {
            HStack {
                _selectImageButton
                Spacer()
                _openCameraButton
            }
            .padding(.horizontal, AppStyle.defaultSpacing)
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(user: MockData.users[0])
    }
}
