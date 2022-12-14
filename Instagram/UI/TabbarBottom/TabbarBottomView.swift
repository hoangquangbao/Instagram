//
//  TabbarBottomView.swift
//  Instagram
//
//  Created by Tran Thuan on 07/10/2022.
//

import SwiftUI

struct TabbarBottomView: View {
    
    @StateObject var userVm = UserViewModel()
    @StateObject var storyVm = StoryViewModel()
    @StateObject var postVm = PostViewModel()
    @StateObject var notificationVm = NotificationViewModel()
    
    @EnvironmentObject var sessionVm: SessionViewModel
    
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 0.0) {
                TabView(selection: $selection) {
                    ForEach(TabbarBottom.allCases, id: \.rawValue) { item in
                        if let user = sessionVm.userInfo {
                            if item == TabbarBottom.notification {
                                item.getView(user: user)
                                    .tag(item.rawValue)
                                    .tabItem {
                                        item.getImage(isActive: selection == item.rawValue)
                                            .renderingMode(.template).foregroundColor(Color._000000)
                                    }
                                    .badge(notificationVm.unReadCount)
                            } else {
                                item.getView(user: user)
                                    .tag(item.rawValue)
                                    .tabItem {
                                        item.getImage(isActive: selection == item.rawValue)
                                            .renderingMode(.template).foregroundColor(Color._000000)
                                    }
                            }
                        }
                    }
                }
                .accentColor(Color.appPrimary)
            }
            .navigationBarBackButtonHidden(true)
            .background {
                Color.appPrimary
            }
            
            if(storyVm.isStoryDisplay) {
                StoryView()
            }
        }
    }
}


//struct TabbarBottomView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabbarBottomView()
//            .environmentObject(StoryViewModel())
//    }
//}

