//
//  NotificationInfoView.swift
//  Instagram
//
//  Created by lhduc on 09/12/2022.
//

import SwiftUI
import Kingfisher


struct NotificationInfoView: View {
    let notification: Notification
    @Binding var isShowDialog: Bool
    @StateObject var vm: NotificationViewModel
    
    @State private var selection: Int? = nil
    
    var body: some View {
        ZStack {
            notification.isRead ? Color.clear : Color.semiText.opacity(0.1)
            
            Button {
                isShowDialog = true
                vm.read(notification: notification) {
                    isShowDialog = false
                    self.selection = 1
                }
            } label: {
                HStack(alignment: .center) {
                    UserAvatar(user: notification.userInteraction!,
                               radius: 55,
                               imageOptions: _getInteractionImage(action: notification.action))
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Group<Text> {
                                Text("\(notification.userInteraction!.fullName) ").bold() +
                                Text(notification.content)
                            }
                            .font(.system(.subheadline))
                            .multilineTextAlignment(.leading)
                            .lineSpacing(0)
                            
                            if(!notification.isRead) {
                                Spacer()
                                Circle().fill(Color(.systemBlue)).frame(width: 10, height: 10)
                            }
                        }
                        
                        
                        Text(notification.getTimeNotifyAgo())
                            .font(.system(.footnote))
                            .foregroundColor(Color.semiText)
                    }
                    
                    Spacer()
                    
                    if let post = notification.post {
                        KFImage(URL(string: post.imagesUrl[0]))
                            .resizable()
                            .frame(width: 45, height: 45)
                            .aspectRatio(contentMode: .fill)
                    }
                    
                }
                .padding(AppStyle.defaultSpacing)
            }
            
            NavigationLink(
                destination: getDestination(),
                tag: 1,
                selection: $selection,
                label: {}
            )
        }
    }
}

private extension NotificationInfoView {
    @ViewBuilder
    func getDestination() -> some View {
        switch notification.type {
        case .post: PostDetailView(post: notification.post)
        default: PostDetailView(post: notification.post!)
        }
    }
    
    func _getInteractionImage(action: NotificationAction) -> UserRowImageOptions {
        switch action {
        case .like:     return UserRowImageOptions(systemName: "heart.fill", backgroundColor: Color(.systemRed))
        case .comment:  return UserRowImageOptions(systemName: "bubble.left.fill")
        case .mention:  return UserRowImageOptions(systemName: "bubble.left.fill")
        }
    }
}


struct NotificationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationInfoView(notification: MockData.notifications[0],
                             isShowDialog: .constant(false),
                             vm: NotificationViewModel())
    }
}
