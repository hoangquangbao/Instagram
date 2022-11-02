//
//  AddPostView.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//

import SwiftUI

struct NewPostView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: NewPostViewModel
    
    @State var photosSelected = [UIImage]()
    @State var imageAttach: UIImage?
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
        .sheet(isPresented: $vm.isBottomSheetDisplayed) {
            ImagePicker(image: $imageAttach, sourceType: vm.sourceType)
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
                    dismiss()
                }
                .font(.subheadline)
                .foregroundColor(Color._000000)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Upload").font(.subheadline)
                }
                .disabled(vm.caption.isEmpty)
            }
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top, 5)
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
                    SquareImageTab(images: vm.uiImageToImage(photosSelected), currentStep: $currentIndex)
                }
                
                if let imageAttach = imageAttach {
                    SquareImageTab(images: [Image(uiImage: imageAttach)], currentStep: $currentIndex)
                }
            }
        } 
    }
    
    var _selectImageButton: some View {
        Button {
            vm.isBottomSheetDisplayed.toggle()
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
            vm.isBottomSheetDisplayed.toggle()
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
