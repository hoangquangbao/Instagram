//
//  UserProfileView.swift
//  Instagram
//
//  Created by lhduc on 10/11/2022.
//

import SwiftUI

struct UserProfileView: View {
    let user: User
    let postCount: Int
    
    @Binding var isShowEditProfile: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading){
                _UserInfo(user: user, postCount: postCount)
                Text(user.fullName)
                    .font(Font.system(size: 13, weight: .medium))
                    .padding(.top, 5)
                    .padding(.bottom, 1)
                _bio
                _editProfileButton
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
    }
}

private extension UserProfileView {
    var _bio: some View {
        Text(user.description)
            .font(Font.system(size: 13, weight: .regular))
            .foregroundColor(.primary)
    }
    var _editProfileButton: some View {
        Button {
            print("Edit profile...")
                isShowEditProfile.toggle()
        } label: {
            Text("Edit Profile")
                .font(Font.system(size: 13, weight: .medium))
                .padding(.vertical, 9)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color(red: 210/255, green: 210/255, blue: 210/255), lineWidth: 0.7)
                )
        }
        .padding(.top, 10)
    }
}

private struct _UserInfo: View {
    let user: User
    let postCount: Int
    
    var body: some View {
        HStack(alignment: .center) {
            _userAvatar
            
            Spacer()
            
            _userOverview
            
            Spacer() .frame(width: 20)
        }
    }
}

private extension _UserInfo {
    var _userAvatar: some View {
        ZStack{
            CircleAvatar(imageUrl: user.avatarUrl, radius: 90)
            
            ZStack{
                Circle()
                    .fill(Color.blue)
                    .frame(width: 25, height: 25)
                
                Image(systemName: "plus")
                    .font(Font.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                
                Circle().stroke(Color.white, lineWidth: 2)
                    .frame(width: 25, height: 25)
            }
            .offset(x: 35, y: 30)
        }
    }
    
    var _userOverview: some View {
        HStack(alignment: .center, spacing:30) {
            _OverviewColumn(quantity: postCount, title: "Posts")
            _OverviewColumn(quantity: user.followers.count, title: "Followers")
            _OverviewColumn(quantity: user.followings.count, title: "Following")
        }
    }
}


private struct _OverviewColumn: View {
    let quantity: Int
    let title: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(quantity.toString()).font(Font.system(size: 17, weight: .medium))
            Text(title).font(.footnote)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(user: MockData.users[0], postCount: 0, isShowEditProfile: .constant(false))
    }
}
