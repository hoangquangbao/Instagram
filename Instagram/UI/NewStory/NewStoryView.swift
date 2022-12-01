//
//  NewStoryView.swift
//  Instagram
//
//  Created by lhduc on 01/11/2022.
//

import SwiftUI

struct NewStoryView: View {
    let user: User
    
    @FocusState var hasTextFieldFocus: Bool
    @StateObject var vm = NewStoryViewModel()
    @EnvironmentObject var userVm: UserViewModel
    @EnvironmentObject var storyVm: StoryViewModel
    @EnvironmentObject var sessionVm: SessionViewModel
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack {
            _header
            
            ScrollView {
                VStack {
                    _caption
                    
                    if let imageAttach = vm.imageAttach {
                        _StoryContent(
                            imageAttach: imageAttach,
                            caption: vm.caption,
                            captionColorHex: vm.captionColorHexSelected,
                            textAlignment: vm.isTextCenter ? .center : .bottom,
                            onTapCloseButton: vm.clearImageAttach
                        )
                    }
                    
                    if vm.imageAttach != nil && vm.caption.isNotEmpty {
                        _captionColors
                        
                        _textAlignOption
                    }
                }
            }
            
            if hasTextFieldFocus {
                EmptyView()
            } else {
                _backgroundTemplates
                _selectFromGalleryButton
            }
            
        }
        .background(Color.f9F9F9)
        .showWaitingDialog(title: "Uploading...", isLoading: $vm.isStoryUploading)
        .alert("Something was wrong", isPresented: $vm.isErrorAlertDisplay) {
            Button("Try again", role: .cancel) { }
        }
        .sheet(isPresented: $vm.isImagePickerDisplay) {
            ImagePicker(image: $vm.imageAttach, sourceType: .photoLibrary)
        }
    }
}

private extension NewStoryView {
    var _header: some View {
        ZStack(alignment: .center) {
            Text("New story")
                .font(.system(size: 18))
                .foregroundColor(Color.black)
                .bold()
            HStack {
                IconButton(imageIcon: Image(systemName: "xmark"), color: Color.black) {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.subheadline)
                
                Spacer()
                
                Button {
                    vm.uploadStory { isSuccess in
                        if(isSuccess) {
                            Task {
                                await userVm.refresh()
                                //                                await storyVm.refresh()
                                await sessionVm.refresh()
                                vm.isStoryUploading.toggle()
                                presentationMode.wrappedValue.dismiss()
                            }
                        } else {
                            vm.isStoryUploading.toggle()
                            vm.isErrorAlertDisplay.toggle()
                        }
                    }
                    
                } label: {
                    Text("Upload").font(.subheadline)
                }
                .foregroundColor(Color(.systemBlue))
                .disabled(vm.caption.isEmpty || vm.imageAttach == nil)
            }
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top, 5)
    }
    
    var _caption: some View {
        TextField("Caption...", text: $vm.caption)
            .focused($hasTextFieldFocus)
            .font(.system(.subheadline))
            .foregroundColor(Color.black)
            .padding(.horizontal, AppStyle.defaultSpacing)
            .padding(.top)
    }
    
    var _captionColors: some View {
        HStack {
            ForEach(vm.colors, id: \.self) { (colorHex: String) in
                Button {
                    withAnimation {
                        vm.captionColorHexSelected = colorHex
                    }
                } label: {
                    Color(colorHex).frame(width: 25).clipShape(Circle())
                        .padding(vm.captionColorHexSelected == colorHex ? 3 : 0)
                        .overlay(
                            Circle()
                                .stroke(Color.gray.opacity(0.4), lineWidth: 2)
                                .shadow(color: Color(colorHex),
                                        radius: vm.captionColorHexSelected == colorHex ? 10 : 0)
                        )
                }
            }
        }
        .frame(height: 25)
    }
    
    var _textAlignOption: some View {
        Button("Center text") {
            withAnimation {
                vm.isTextCenter.toggle()
            }
        }
        .myStyle(vm.isTextCenter ? .bordered : .borderless)
        .font(.subheadline)
        .foregroundColor(Color.black)
        .padding(.top, 5)
    }
    
    var _backgroundTemplates: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(vm.templates, id: \.self) { template in
                    Button {
                        vm.selectTemplate(for: template)
                    } label: {
                        Image(template)
                            .resizable()
                            .frame(width: UIScreen.screenWidth / 4,
                                   height: UIScreen.screenWidth / 4)
                            .scaledToFill()
                            .cornerRadius(10)
                            .padding(5)
                            .background(self.getBorderColor(for: template))
                            .cornerRadius(10)
                    }
                }
            }
        }
        .padding(.leading, AppStyle.defaultSpacing)
    }
    
    var _selectFromGalleryButton: some View {
        Button {
            vm.isImagePickerDisplay.toggle()
            vm.clearImageAttach()
        } label: {
            Text("Select from gallery")
        }
        .buttonStyle(CustomButtonStyle(foregroundColor: Color.white, bgColor: Color.black))
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top)
    }
    
    func getBorderColor(for template: String) -> Color {
        guard let templateSelected = vm.templateSelected else {
            return Color.clear
        }
        
        if(templateSelected == template) {
            return Color.primary.opacity(0.7)
        }
        
        return Color.clear
    }
}


private struct _StoryContent: View {
    let imageAttach: UIImage
    let caption: String
    let captionColorHex: String
    var textAlignment: Alignment = .bottom
    let onTapCloseButton: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: textAlignment) {
                SquareImageTab(images: [imageAttach] as! [UIImage], currentStep: .constant(0))
                
                Text(caption)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(captionColorHex))
                    .padding(.horizontal, 12)
                    .padding(.bottom, 8)
            }
            Button {
                onTapCloseButton()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .padding(.top, 5)
    }
}

struct NewStoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewStoryView(user: MockData.users[0])
            .environmentObject(UserViewModel())
            .environmentObject(PostViewModel())
            .environmentObject(StoryViewModel())
    }
}
