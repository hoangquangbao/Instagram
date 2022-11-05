import SwiftUI

struct ActionSheetCustom: View {
    
    @Binding var isShowImagePicker: Bool
    @Binding var isShowImagePickerOptions: Bool
    @Binding var sourceType: UIImagePickerController.SourceType
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(isShowImagePickerOptions ? 0.6 : 0)
                .transition(.opacity)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isShowImagePickerOptions = false
                    }
                }
//                .edgesIgnoringSafeArea(.all)
            
            if isShowImagePickerOptions {
                VStack {
                    VStack(spacing: 0) {
                        Text(Localization.chooseTitle)
                            .foregroundColor(.gray)
                            .font(.sfProTextRegular(15, relativeTo: .title1))
                            .padding(.vertical, 15)
                        
                        Divider()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                        
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            ActionSheetItem(title: Localization.cameraTitle,
                                            color: .gray,
                                            font: .sfProTextMedium(20, relativeTo: .title1),
                                            isShowImagePickerOptions: $isShowImagePickerOptions) {
                                isShowImagePicker = true
                                sourceType = .camera
                            }
                        }
                        
                        ActionSheetItem(title: Localization.photoLibraryTitle,
                                        color: .gray,
                                        font: .sfProTextMedium(20, relativeTo: .title1),
                                        isShowImagePickerOptions: $isShowImagePickerOptions) {
                            isShowImagePicker = true
                            sourceType = .photoLibrary
                        }
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    ActionSheetItem(title: Localization.cancelTitle,
                                    color: .gray,
                                    font: .sfProTextMedium(20, relativeTo: .title1),
                                    isShowImagePickerOptions: $isShowImagePickerOptions,
                                    action: {})
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding()
                .transition(.move(edge: .bottom))
                .animation(.easeInOut(duration: 0.3), value: isShowImagePickerOptions)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ActionSheetCustom_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetCustom(isShowImagePicker: .constant(false), isShowImagePickerOptions: .constant(true), sourceType: .constant(.camera))
            .background(Color.gray.opacity(0.6))
    }
}

// MARK: - Localization
private enum Localization {
    static let chooseTitle = NSLocalizedString("Select a source", comment: "Action sheet title.")
    static let cameraTitle = NSLocalizedString("Camera", comment: "Action sheet text for 'Camera' option.")
    static let photoLibraryTitle = NSLocalizedString("Photo Library", comment: "Action sheet text for 'Photo Library' option.")
    static let cancelTitle = NSLocalizedString("Cancel", comment: "Action sheet text for 'Cancel' option.")
}
