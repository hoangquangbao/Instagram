//
//  NotificationView.swift
//  Instagram
//
//  Created by lhduc on 17/11/2022.
//

import SwiftUI

struct NotificationView: View {
    @EnvironmentObject var vm: NotificationViewModel
    
    @State private var isWaitingDialogDisplayed: Bool = false
    
    init() {
        print("Init notification view")
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    NotificationHeaderView()
                    
                    if(vm.isFetching) {
                        NotificationInfoShimmer()
                            .padding(.horizontal, AppStyle.defaultSpacing)
                    }
                    else {
                        if(vm.notifications.isNotEmpty) {
                            ScrollView {
                                LazyVStack {
                                    ForEach(vm.notifications) { notification in
                                        NotificationInfoView(notification: notification, isShowDialog: $isWaitingDialogDisplayed, vm: vm)
                                    }
                                }
                            }
                        } else {
                            EmptyNotificationView()
                        }
                    }
                    
                    
                }
            }
            .navigationBarHidden(true)
            .showWaitingDialog(title: "Please wait...", isLoading: $isWaitingDialogDisplayed)
        }
    }
}


struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
