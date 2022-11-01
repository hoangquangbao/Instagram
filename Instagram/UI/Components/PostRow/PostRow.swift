//
//  PostRow.swift
//  Instagram
//
//  Created by lhduc on 14/10/2022.
//

import SwiftUI

struct PostRow: View {
    
    @State private var _imageSelectionIndex = 0
    @ObservedObject var vm: PostRowViewModel
    
    init(post: Post) {
        self.vm = PostRowViewModel(post: post)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            _header
            
            _content
            
            if(vm.post.likeCount > 0) {
                LikeInfoRow(user: vm.latestUserLikePost!, likeCount: vm.likeCount)
            }
            
            Text(vm.post.caption)
                .font(.footnote)
                .padding(.top, 8)
                .padding(.horizontal, AppStyle.defaultSpacing)
            
            if(vm.post.commentCount > 0) {
                _showAllCommentButton
            }
            
            _commentArea
        }
    }
}

private extension PostRow {
    var _header: some View {
        HStack {
            HStack(spacing: 9.0) {
                if let user = vm.post.user {
                    CircleAvatar(imageUrl: user.avatarUrl, radius: 40)
                    VStack(alignment: .leading) {
                        Text(user.fullName)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Text("@\(user.username)")
                            .font(.caption)
                            .fontWeight(.light)
                    }
                }
            }
            
            Spacer()
            
            Image.icnMore
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top, 15)
        .padding(.bottom, 8)
    }
    
    var _content: some View {
        VStack {
            SquareImageTab(images: vm.imagesUrlToImageView(), currentStep: $_imageSelectionIndex)
            HStack {
                HStack(spacing: 10.0) {
                    IconButton(imageIcon: Image.icnHeart, onTap: vm.onFavorite)
                    
                    IconButton(imageIcon: Image.icnComment, onTap: vm.onComment)
                    
                    IconButton(imageIcon: Image.icnShare, onTap: vm.onMessage)
                }
                
                if(vm.imageCount > 1) {
                    ImageTabIndicator(tabCount: vm.imageCount, activeIndex: $_imageSelectionIndex)
                        .padding(.leading, 60)
                }
                
                Spacer()
                
                IconButton(imageIcon: Image.icnBookmark, onTap: vm.onShare)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
        }
    }
    
    var _showAllCommentButton: some View {
        Button(action: vm.showAllComment) {
            Text("Show all \(vm.commentCount) comment")
                .font(.footnote)
                .foregroundColor(Color.semiText)
        }
        .padding(.top, 5)
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
    
    var _commentArea: some View {
        HStack {
            HStack {
                if let user = vm.post.user {
                    CircleAvatar(imageUrl: user.avatarUrl, radius: 30)
                }
                Text("Add comment").font(.footnote).foregroundColor(Color.semiText)
                
            }
            Spacer()
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top, 12)
    }
}

struct LikeInfoRow: View {
    let user: User
    let likeCount: Int
    
    var body: some View {
        HStack {
            CircleAvatar(imageUrl: user.avatarUrl, radius: 20)
            Group<Text> {
                Text("Liked by ") +
                Text("\(user.fullName) ").bold() +
                Text("and ") +
                Text("\(likeCount - 1) others").bold()
            }
            .font(.caption)
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top, 5)
        
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostRow(post: MockData.posts[0])
            PostRow(post: MockData.posts[1])
            PostRow(post: MockData.posts[2])
            PostRow(post: MockData.posts[3])
        }
    }
}
