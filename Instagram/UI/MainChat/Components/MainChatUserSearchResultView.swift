//
//  MainChatSearchResultView.swift
//  Instagram
//
//  Created by lhduc on 16/01/2023.
//

import SwiftUI

struct MainChatUserSearchResultView: View {
    @EnvironmentObject var vm: MainChatViewModel
    @EnvironmentObject var userVm: UserViewModel
    @EnvironmentObject var sessionVm: SessionViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(userVm.searchableUser(vm.searchText)) { user in
                    NavigationLink {
                        ConversationView(conversation: vm.findConversation(of: sessionVm.userInfo, with: user))
                    } label: {
                        UserRow(user: user).padding(.vertical, 5)
                    }
                }
            }
            .padding(AppStyle.defaultSpacing)
        }
    }
}

struct MainChatUserSearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        MainChatUserSearchResultView()
    }
}
