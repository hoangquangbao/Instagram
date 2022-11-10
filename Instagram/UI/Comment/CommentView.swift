//
//  CommentView.swift
//  Instagram
//
//  Created by lhduc on 10/11/2022.
//

import SwiftUI

struct CommentView: View {
    
    @State var commentText: String = ""
    @StateObject var postRowVm: PostRowViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var sessionVm: SessionViewModel
    
    
    var body: some View {
        VStack {
            _comments
            
            Spacer()
            
            _commentBar
        }
        .navigationBarTitle("Comment", displayMode: .inline)
        .padding(.top)
    }
}

private extension CommentView {
    var _comments: some View {
        HStack(alignment: .top) {
            if let user = sessionVm.userInfo {
                CircleAvatar(imageUrl: user.avatarUrl, radius: 30)
                VStack(alignment: .leading) {
                    Text(user.username).font(.system(.subheadline)).bold()
                    Text("asdasdasdasdas dasd adsfcsdfdasfasdfasdfdsffdsfdsfdsfdsfdsfdsfdsfdsfsdfdsfadsfasdfasdfadsfadsf")
                        .font(.system(.caption))
                }
                Button(action: postRowVm.handleLike) {
                    if postRowVm.post.likes.contains(sessionVm.uid) {
                        Image.icnHeartBold
                            .renderingMode(.template)
                            .foregroundColor(Color.red)
                    } else {
                        Image.icnHeart
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
            TextField("Enter comment here...", text: $commentText)
                .font(.subheadline)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(Color.background)
                .clipShape(Capsule())
                .overlay(
                    Capsule().stroke(Color(.systemGray).opacity(0.8))
                )
            Button {
                
            } label: {
                Image.icnShare
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
