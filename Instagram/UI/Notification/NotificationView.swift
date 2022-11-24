//
//  NotificationView.swift
//  Instagram
//
//  Created by lhduc on 17/11/2022.
//

import SwiftUI
import Kingfisher

struct NotificationView: View {
    @EnvironmentObject var vm: NotificationViewModel
    
    @State private var isWaitingDialogDisplayed: Bool = false
    
//    init() {
//        Task { [self] in
//            await vm.getAll()
//        }
//    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    Text("Notifications")
                        .font(.system(.title2))
                        .bold()
                        .padding(AppStyle.defaultSpacing)
                    
                    ScrollView {
                        LazyVStack {
                            if(vm.isFetching) {
                                NotificationInfoShimmer()
                                    .padding(.horizontal, AppStyle.defaultSpacing)
                                Spacer()
                            } else {
                                if(vm.notifications.isNotEmpty) {
                                    ForEach(vm.notifications) { notification in
                                        NotificationInfo(notification: notification, isShowDialog: $isWaitingDialogDisplayed, vm: vm)
                                    }
                                } else {
                                    Text("Don't have any notification yet")
                                        .font(.system(.title))
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .showWaitingDialog(title: "Please wait...", isLoading: $isWaitingDialogDisplayed)
        }
    }
}

struct NotificationInfo: View {
    let notification: Notification
    @Binding var isShowDialog: Bool
    @ObservedObject var vm: NotificationViewModel
    
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
                    UserAvatar(user: notification.userInteraction!, radius: 50)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Group<Text>() {
                                Text("\(notification.userInteraction!.fullName) ").bold() +
                                Text(notification.content)
                            }
                            .font(.system(.subheadline))
                            .multilineTextAlignment(.leading)
                            
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
    
    @ViewBuilder
    func getDestination() -> some View {
        switch notification.type {
        case .post: return PostDetailView(post: notification.post)
        default: return PostDetailView(post: notification.post!)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
