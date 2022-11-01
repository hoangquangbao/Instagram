//
//  UserRow.swift
//  Instagram
//
//  Created by lhduc on 13/10/2022.
//

import SwiftUI

struct UserRow: View {
    let user: User
    let avatarSize: CGFloat = AppStyle.defaultAvatarSize
    
    private let _avatarSize: CGFloat = 44.0
    
    var body: some View {
        HStack() {
            _circleAvatarBuilder
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .font(.subheadline).bold()
                    .foregroundColor(Color.appPrimary)
                
                Text(user.fullName)
                    .font(.caption)
                    .foregroundColor(Color.semiText)
            }
            Spacer()
        }
    }
}

private extension UserRow {
    @ViewBuilder
    var _circleAvatarBuilder: some View {
        if(user.hasStory) {
            CircleAvatar(imageUrl: user.avatarUrl, radius: _avatarSize)
                .addGradientBorder(gradient: AppStyle.storyLinearGradient)
        } else {
            CircleAvatar(imageUrl: user.avatarUrl, radius: _avatarSize)
        }
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UserRow(user: MockData.users[0])
            UserRow(user: MockData.users[1])
            UserRow(user: MockData.users[2])
            UserRow(user: MockData.users[3])
        }
        .previewLayout(.fixed(width: UIScreen.screenWidth, height: 100))
    }
}
