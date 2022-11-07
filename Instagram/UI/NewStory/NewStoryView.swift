//
//  NewStoryView.swift
//  Instagram
//
//  Created by lhduc on 01/11/2022.
//

import SwiftUI

struct NewStoryView: View {
    let user: User
    
    @StateObject var vm = NewStoryViewModel()
    @EnvironmentObject var userVm: UserViewModel
    @EnvironmentObject var postVm: PostViewModel
    @EnvironmentObject var storyVm: StoryViewModel
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack {
            _header
            _caption
            
            if let imageAttach = vm.imageAttach {
                _StoryContent(
                    imageAttach: imageAttach,
                    caption: vm.caption,
                    captionColorHex: vm.captionColorHexSelected,
                    onTapCloseButton: vm.clearImageAttach
                )
            }
            
            Spacer()
            
            if vm.imageAttach != nil && vm.caption.isNotEmpty {
                _captionColors
            }
            
            _backgroundTemplates
            _selectFromGalleryButton
            
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
    
    func getColorBorder(for template: String) -> Color {
        guard let templateSelected = vm.templateSelected else {
            return Color.clear
        }
        
        if(templateSelected == template) {
            return Color.primary.opacity(0.7)
        }
        
        return Color.clear
    }
}

private extension NewStoryView {
    var _header: some View {
        ZStack(alignment: .center) {
            Text("New story")
                .font(.system(size: 18))
                .bold()
            HStack {
                IconButton(imageIcon: Image(systemName: "xmark")) {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.subheadline)
                .foregroundColor(Color._000000)
                
                Spacer()
                
                Button {
                    vm.uploadStory { isSuccess in
                        if(isSuccess) {
                            vm.isStoryUploading.toggle()
                            userVm.refresh()
                            postVm.refresh()
                            storyVm.refresh()
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            vm.isStoryUploading.toggle()
                            vm.isErrorAlertDisplay.toggle()
                        }
                    }
                    
                } label: {
                    Text("Upload").font(.subheadline)
                }
                .disabled(vm.caption.isEmpty || vm.imageAttach == nil)
            }
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top, 5)
    }
    
    var _caption: some View {
        TextField("Caption...", text: $vm.caption)
            .font(.system(.subheadline))
            .padding(.horizontal, AppStyle.defaultSpacing)
            .padding(.top)
    }
    
    var _captionColors: some View {
        HStack {
            ForEach(vm.colors, id: \.self) { (colorHex: String) in
                Button {
                    withAnimation() {
                        vm.captionColorHexSelected = colorHex
                    }
                } label: {
                    Color(colorHex).frame(width: 28).clipShape(Circle())
                        .padding(vm.captionColorHexSelected == colorHex ? 3 : 0)
                        .overlay(
                            Circle().stroke(Color.gray.opacity(0.4), lineWidth: 2)
                                .shadow(color: Color(colorHex), radius: vm.captionColorHexSelected == colorHex ? 10 : 0, x: 0, y: 0)
                        )
                }
            }
        }
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
                            .background(self.getColorBorder(for: template))
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
        .buttonStyle(CustomButtonStyle(foregroundColor: Color.ffffff, bgColor: Color.appPrimary))
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top)
    }
}

private struct _StoryContent: View {
    let imageAttach: UIImage
    let caption: String
    let captionColorHex: String
    let onTapCloseButton: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
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
    }
}
