import SwiftUI

struct PostOptionView: View {
    let post: Post
    @Binding var isShowDeletePostAlert: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators:false) {
            ForEach(postOptionData){ item in
                VStack {
                    Button {
                        if item.title == "Edit" {
                            print("Edit Post")
                        } else {
                            isShowDeletePostAlert.toggle()
                        }
                    } label: {
                        _lable(item: item)
                    }
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
