//
//  NotificationView.swift
//  Instagram
//
//  Created by lhduc on 17/11/2022.
//

import SwiftUI
import Kingfisher

struct NotificationView: View {
    @ObservedObject var vm = NotificationViewModel()
    
    init() {
        Task { [self] in
            await vm.getAll()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVStack {
                        if(vm.isFetching) {
                            CommentRowShimmer()
                            Spacer()
                        } else {
                            ForEach(vm.notifications) { notification in
                                NavigationLink {
                                    PostDetailView(post: notification.post!)
                                } label: {
                                    HStack(alignment: .center) {
                                        CircleAvatar(imageUrl: notification.userInteraction!.avatarUrl, radius: 50)
                                        
                                        VStack(alignment: .leading) {
                                            Group<Text>() {
                                                Text("\(notification.userInteraction!.fullName) ").bold() +
                                                Text(notification.content)
                                            }
                                            .font(.system(.subheadline))
                                            .multilineTextAlignment(.leading)
                                            
                                            Text(notification.getTimeNotifyAgo())
                                                .font(.system(.footnote))
                                                .foregroundColor(Color.semiText)
                                        }
                                        
                                        Spacer()
                                        
                                        KFImage(URL(string: notification.post!.imagesUrl[0]))
                                            .resizable()
                                            .frame(width: 45, height: 45)
                                            .aspectRatio(contentMode: .fill)
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding(AppStyle.defaultSpacing)
        }
    }
    
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
