//
//  CreateNewStoryButton.swift
//  Instagram
//
//  Created by lhduc on 07/11/2022.
//

import SwiftUI

struct CreateNewStoryButton: View {
    @ObservedObject var homeVm: HomeViewModel
    @EnvironmentObject var sessionVm: SessionViewModel
    @EnvironmentObject var userVm : UserViewModel
    
    var body: some View {
        VStack {
            Button {
                guard let user = sessionVm.userInfo else { return }
                if user.hasStory {
                    homeVm.isShowOptionForNavigateStoryView.toggle()
                } else {
                    homeVm.isShowNewStoryView.toggle()
                }
            } label: {
                ZStack(alignment: .bottomTrailing) {
                    _circleAvatarBuilder
                    
                    _plusIcon
                }
            }
            .fullScreenCover(isPresented: $homeVm.isShowNewStoryView) {
                if let userInfo = sessionVm.userInfo {
                    NewStoryView(user: userInfo)
                }
            }
            
            Text("Your story").font(.caption)

            
        }
        .padding(.top, 8)
    }
}

private extension CreateNewStoryButton {
    @ViewBuilder
    var _circleAvatarBuilder: some View {
        if let userInfo = sessionVm.userInfo {
            if(userInfo.hasStory) {
                CircleAvatar(imageUrl: userInfo.avatarUrl, radius: 55)
                    .addGradientBorder(gradient: AppStyle.storyLinearGradient)
            } else {
                CircleAvatar(imageUrl: userInfo.avatarUrl, radius: 55)
                    .addBorder(Color.clear)
            }
            
        } else {
            UserRowShimmer().circleAvatar(radius: 55)
        }
    }
}

private extension CreateNewStoryButton {
    var _plusIcon: some View {
        ZStack {
            Circle().fill(Color.ffffff).frame(width: 25, height: 25)
            Image(systemName: "plus.circle.fill")
                .renderingMode(.template)
                .resizable()
                .foregroundColor(Color.blue)
                .background(Color.clear)
                .frame(width: 20, height: 20)
        }
    }
}


struct CreateNewStoryButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewStoryButton(homeVm: HomeViewModel())
    }
}
