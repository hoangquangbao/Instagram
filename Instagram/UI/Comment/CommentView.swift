//
//  CommentView.swift
//  Instagram
//
//  Created by lhduc on 10/11/2022.
//

import SwiftUI

struct CommentView: View {

    @StateObject var postRowVm: PostRowViewModel    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var sessionVm: SessionViewModel
    
    
    var body: some View {
        ZStack {
            VStack {
                _comments
                
                Spacer()
                
                _commentBar
            }
            .navigationBarTitle("Comment", displayMode: .inline)
            .padding(.top)
        }
        .onAppear(perform: postRowVm.loadComment)
    }
}

private extension CommentView {
    var _comments: some View {
        HStack(alignment: .top) {
            if let comments = postRowVm.post.comments {
                ForEach(comments) { comment in
                    if let user = comment.user {
                        CircleAvatar(imageUrl: user.avatarUrl, radius: 30)
                        VStack(alignment: .leading) {
                            Text(user.username).font(.system(.subheadline)).bold()
                            Text(comment.comment)
                                .font(.system(.caption))
                        }
                        Spacer()
                        IconButton(imageIcon: Image.icnHeart, size: 15) {}
                    }
                }
            }
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
    
    var _commentBar: some View {
        HStack(spacing: 10) {
            if let user = sessionVm.userInfo {
                CircleAvatar(imageUrl: user.avatarUrl, radius: 30)
            }
            TextField("Enter comment here...", text: $postRowVm.commentText)
                .font(.subheadline)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(Color.background)
                .clipShape(Capsule())
                .overlay(
                    Capsule().stroke(Color(.systemGray).opacity(0.8))
                )
            Button(action: postRowVm.createComment) {
                Image.icnShare
                    .renderingMode(.template)
                    .foregroundColor(Color.primary)
            }
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.bottom)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(postRowVm: PostRowViewModel(post: MockData.posts[0]))
    }
}
