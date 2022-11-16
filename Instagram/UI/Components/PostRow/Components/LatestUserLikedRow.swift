//
//  UserLikedInfoRow.swift
//  Instagram
//
//  Created by lhduc on 14/11/2022.
//

import SwiftUI

struct LatestUserLikedRow: View {
    let user: User?
    let likeCount: Int
    
    var body: some View {
        if (user != nil && likeCount > 0) {
            _info
        }
        else if likeCount > 0 {
            _loadingShimmer
        }
    }
}

private extension LatestUserLikedRow {
    var _info: some View {
        HStack {
            CircleAvatar(imageUrl: user!.avatarUrl, radius: 20)
            HStack(spacing: 0) {
                Text("Liked by ")
                Text("\(user!.fullName) ").bold()
                if(likeCount > 1) {
                    HStack<Text>(spacing: 0) {
                        Text("and ") + Text("\(likeCount - 1) others").bold()
                    }
                } else {
                    Text("")
                }
            }
            .font(.caption)
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top, 5)
    }
    
    var _loadingShimmer: some View {
        HStack {
            Circle().frame(width: 20).shimmering()
            
            Text("Loading...").font(.caption).shimmering()
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top, 5)
    }
}

struct LatestUserLikedRow_Previews: PreviewProvider {
    static var previews: some View {
        LatestUserLikedRow(user: MockData.users[0], likeCount: 1)
    }
}
