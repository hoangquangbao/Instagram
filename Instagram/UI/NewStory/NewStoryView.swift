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
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack {
            
            _header
            
            TextField("Caption...", text: $vm.caption)
                .font(.system(.subheadline))
                .padding(.horizontal, AppStyle.defaultSpacing)
                .padding(.top)
            
            if let imageAttach = vm.imageAttach {
                ZStack(alignment: .topTrailing) {
                    SquareImageTab(images: [imageAttach] as! [UIImage], currentStep: .constant(0))
                    Button(action: vm.clearImageAttach) {
                        Image(systemName: "xmark.circle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Text(vm.caption).font(.headline).foregroundColor(Color(vm.captionColorHexSelected))
                }
            }
            
            Spacer()
            
            _captionColors
            
            _backgroundTemplates
            
            _selectFromGalleryButton
        }
        .background(Color.f9F9F9)
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
                    print("upload")
                } label: {
                    Text("Upload").font(.subheadline)
                }
                .disabled(vm.caption.isEmpty || vm.imageAttach == nil)
            }
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top, 5)
    }
    
    var _captionColors: some View {
        HStack {
            
            ForEach(vm.colors, id: \.self) { (colorHex: String) in
                Button {
                    vm.captionColorHexSelected = colorHex
                } label: {
                    Color(colorHex).frame(width: 28).clipShape(Circle()).padding(vm.captionColorHexSelected == colorHex ? 3 : 0)
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
                            .frame(width: UIScreen.screenWidth / 4, height: UIScreen.screenWidth / 4)
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

struct NewStoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewStoryView(user: MockData.users[0])
    }
}
