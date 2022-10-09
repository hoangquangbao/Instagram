import SwiftUI

struct PhoneTextFieldView: View {
    
    @State private var areaCode: String = "VN +84"
    private var title: String = "Phone number"
    @State var phoneNumber: String = ""

    var body: some View {
            HStack(spacing: 0) {
                Button {
                    print("Not implemented yet!")
                } label: {
                    Text(" " + areaCode + " ")
                        .font(.sfProTextRegular(16, relativeTo: .caption1))
                }
                
                Divider()
                    .frame(width: 15)
                    .padding(.vertical, 5)
                
                TextField(title, text: $phoneNumber, onEditingChanged: { editing in
                    //On-hold
                })
                .textFieldStyle(CustomPhoneTextFieldStyle())
            }
            .frame(height: 45)
            .overlay {
                RoundedRectangle(cornerRadius: 5).stroke(Color.black.opacity(0.5), lineWidth: 0.5)
            }
    }
}

struct PhoneTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneTextFieldView()
    }
}
