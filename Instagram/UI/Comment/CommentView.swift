//
//  CommentView.swift
//  Instagram
//
//  Created by lhduc on 10/11/2022.
//

import SwiftUI

struct CommentView: View {
    @StateObject var postRowVm: PostRowViewModel
    @ObservedObject var vm = CommentViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var sessionVm: SessionViewModel
    @EnvironmentObject var userVm: UserViewModel
    
    
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { proxy in
                    ScrollView {
                        if postRowVm.commentState == .comment {
                            _comments
                        } else if postRowVm.commentState == .mention {
                            UsersMentionView(postRowVm: postRowVm)
                        }
                    }
                    .frame(height: proxy.size.height)
                }
                Text(postRowVm.commentState.rawValue)
                _commentBar
            }
        }
        .navigationBarTitle("Comment", displayMode: .inline)
        .padding(.top)
        .showWaitingDialog(title: "Please wait...", isLoading: $vm.isShowWaitingDialog)
        .task {
            await postRowVm.loadComment()
        }
    }
}


private extension CommentView {
    var _comments: some View {
        LazyVStack(alignment: .leading) {
            if let comments = postRowVm.post.comments {
                ForEach(comments) { comment in
                    CommentRow(comment: comment)
                }
            } else {
                CommentRowShimmer()
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
                .overlay(Capsule().stroke(Color(.systemGray).opacity(0.8)))
                .onChange(of: postRowVm.commentText) { newValue in
                    postRowVm.onCommentTextChange(newValue)
                }
            
            Button(action: _postComment) {
                Image.icnShare
                    .renderingMode(.template)
                    .foregroundColor(Color.primary)
            }
            .disabled(postRowVm.commentText.isEmpty)
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.bottom)
    }
}

private extension CommentView {
    func _postComment() {
        vm.isShowWaitingDialog = true
        postRowVm.createComment()
        postRowVm.notifyToMentionUsers(of: postRowVm.post, users: userVm.users)
        Task {
            await postRowVm.loadComment()
            postRowVm.commentText = ""
            vm.isShowWaitingDialog.toggle()
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(postRowVm: PostRowViewModel(post: MockData.posts[0]))
            .environmentObject(SessionViewModel())
    }
}
