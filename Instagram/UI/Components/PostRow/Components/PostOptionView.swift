import SwiftUI

struct PostOptionView: View {
    @Binding var isShowEditPost: Bool
    @Binding var isShowDeletePostAlert: Bool
    
    var body: some View {
        ForEach(postOptionData){ item in
            VStack {
                Button {
                    if item.title == "Edit" {
                        print("Editting Post")
                        isShowEditPost.toggle()
                    } else {
                        print("Deleting Post")
                        isShowDeletePostAlert.toggle()
                    }
                } label: {
                    _lable(item: item)
                }
            }
        }
    }
}

private extension PostOptionView {
    func _lable(item: StaticList) -> some View {
        HStack(alignment: .center, spacing: 15){
            item.image
                .resizable()
                .scaledToFill()
                .frame(width: 24, height: 24)
            Text(item.title)
                .font(Font.system(size: 17, weight: .regular))
        }
    }
}
