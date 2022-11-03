import SwiftUI

@available(iOS 16.0, *)
struct OptionsView: View {
    
    @Binding var bottomSheetShow: Bool
    @Binding var isShowDetailOption: Bool
    @Binding var title: String
    
    var body: some View {
            ScrollView(.vertical, showsIndicators:false) {
                ForEach(SettingListData){ item in
                    VStack(alignment: .leading){
                        Button {
                            withAnimation {
                                bottomSheetShow.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isShowDetailOption.toggle()
                            }
                            title = item.title
                        } label: {
                            HStack(alignment: .center, spacing: 15){
                                item.image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 24, height: 24)
                                Text(item.title)
                                    .font(Font.system(size: 17, weight: .regular))
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 15)
                        }
                        .disabled(item.title != "Settings")
                        Divider()
                            .padding(.leading, 50)
                    }
                }
            }
            .background(Color.white)
    }
}

@available(iOS 16.0, *)
struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView(bottomSheetShow: .constant(false), isShowDetailOption: .constant(false), title: .constant(""))
    }
}
