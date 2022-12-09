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
                            }
                            else {
                                if(vm.notifications.isNotEmpty) {
                                    ForEach(vm.notifications) { notification in
                                        NotificationInfoView(notification: notification, isShowDialog: $isWaitingDialogDisplayed, vm: vm)
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


struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
