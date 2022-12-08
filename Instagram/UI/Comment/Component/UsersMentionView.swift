//
//  UsersMentionView.swift
//  Instagram
//
//  Created by lhduc on 08/12/2022.
//

import SwiftUI

struct UsersMentionView: View {
    @StateObject var postRowVm: PostRowViewModel
    @EnvironmentObject var userVm: UserViewModel
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(userVm.searchableUser(postRowVm.mentionUserText)) { user in
                Button {
                    postRowVm.selectMentionUser(user)
                } label: {
                    UserRow(user: user, isShowStoryBorder: false)
                }
                Divider()
                
            }
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
}

struct UsersMentionView_Previews: PreviewProvider {
    static var previews: some View {
        UsersMentionView(postRowVm: PostRowViewModel(post: MockData.posts[0]))
            .environmentObject(UserViewModel())
    }
}
