//
//  StoryAvatar.swift
//  Instagram
//
//  Created by lhduc on 07/11/2022.
//

import SwiftUI

struct StoryAvatar: View {
    let user: User
    @EnvironmentObject var storyVm: StoryViewModel
    @EnvironmentObject var userVm: UserViewModel
    
    var body: some View {
        if userVm.isFetching {
            StoryAvatarShimmer()
        } else {
            VStack {
                Button(action: _onTap) {
                    CircleAvatar(imageUrl: user.avatarUrl, radius: 55)
                        .addGradientBorder(gradient: AppStyle.storyLinearGradient)
                }
                
                Text(user.fullName)
                    .font(.caption)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(width: 65)
            }
        }
    }
    
    func _onTap() {
        guard let uid = user.id else { return }
        storyVm.activeStories = storyVm.userStories(of: uid)
        withAnimation {
            storyVm.isStoryDisplay.toggle()
        }
    }
}

struct StoryAvatar_Previews: PreviewProvider {
    static var previews: some View {
        StoryAvatar(user: MockData.users[0])
    }
}
