//
//  CommentView.swift
//  Instagram
//
//  Created by lhduc on 10/11/2022.
//

import SwiftUI

struct CommentView: View {
    
    @ObservedObject var postRowVm: PostRowViewModel
    @StateObject var vm = CommentViewModel()

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var sessionVm: SessionViewModel
    
    var body: some View {
        let _ = Self._printChanges()
        ZStack {
            VStack {
                _comments
                
                _commentBar
            }
            .navigationBarTitle("Comment", displayMode: .inline)
            .padding(.top)
        }
        .showWaitingDialog(title: "Please wait...", isLoading: $vm.isShowWaitingDialog)
        .task {
            await postRowVm.loadComment()
        }
    }
}


private extension CommentView {
    var _comments: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 30) {
                if let comments = postRowVm.post.comments {
                    ForEach(comments) { comment in
                        CommentRow(comment: comment)
                    }
                } else {
                    CommentRowShimmer()
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
            
            Button(action: postComment) {
                Image.icnShare
                    .renderingMode(.template)
                    .foregroundColor(Color.primary)
            }
            .disabled(postRowVm.commentText.isEmpty)
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.bottom)
    }
    
    func postComment() {
        vm.isShowWaitingDialog = true
        postRowVm.createComment()
        Task {
//            await postRowVm.loadComment()
            postRowVm.commentText = ""
            vm.isShowWaitingDialog.toggle()
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(postRowVm: PostRowViewModel(post: MockData.posts[0]))
    }
}
