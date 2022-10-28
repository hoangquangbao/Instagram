import SwiftUI

struct ActionSheetItem: View {
    
    var title: String
    var color: Color
    var font: Font
    var action: () -> ()
    
    @Binding var isShowImagePickerOptions: Bool
    
    init(title: String,
         color: Color = .gray,
         font: Font = .sfProTextMedium(20, relativeTo: .title1),
         isShowImagePickerOptions: Binding<Bool>,
         action: @escaping () -> Void)
    {
        self.title = title
        self.color = color
        self.font = font
        self.action = action
        self._isShowImagePickerOptions = isShowImagePickerOptions
    }
    
    var body: some View {
        Button {
            action()
            withAnimation(.easeInOut) {
                isShowImagePickerOptions = false
            }
        } label: {
            Text(title)
                .foregroundColor(color)
                .font(font)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
        }
    }
}

struct ActionSheetItem_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetItem(title: "Photo Library", isShowImagePickerOptions: .constant(false), action: {})
    }
}
