//
//  PostRow.swift
//  Instagram
//
//  Created by lhduc on 14/10/2022.
//

import SwiftUI
import Shimmer

struct PostRow: View {
    @State private var _imageSelectionIndex = 0
    @ObservedObject var vm: PostRowViewModel
    @EnvironmentObject var homeVm: HomeViewModel
    
    init(post: Post) {
        self.vm = PostRowViewModel(post: post)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            _header
            
            _content
            
            LatestUserLikedRow(user: vm.post.latestUserLikePost, likeCount: vm.likeCount)
            
            _caption
            
            if(vm.post.commentCount > 0) {
                _showAllCommentButton
            }
            
            _commentArea
            
            _postTime
            
            NavigationLink(
                destination: CommentView(postRowVm: vm),
                tag: 1,
                selection: $vm.isNavigateCommentView,
                label: {}
            )
            
            NavigationLink(
                destination: ProfileView(user: vm.post.user!),
                tag: 1,
                selection: $vm.isNavigateProfileView,
                label: {}
            )
        }
        .fullScreenCover(isPresented: $vm.isShowEditPost) {
            EditPostView(post: vm.post)
        }
        .alert(isPresented: $vm.isShowDeletePostAlert, content: {
            Alert(title: Text("Delete this post?"),
                  primaryButton: .destructive(Text("Delete"), action: {
                vm.deletePost { isSuccess, error in
                    vm.isShowWaitingDialog.toggle()
                    if(isSuccess) {
                        vm.isShowWaitingDialog.toggle()
                    } else {
                        vm.isShowWaitingDialog.toggle()
                        print(error?.localizedDescription as Any)
                    }
                }
            }),
                  secondaryButton: .cancel())
        })
        .showWaitingDialog(title: vm.waitingDialogTitle, isLoading: $vm.isShowWaitingDialog)
    }
}

private extension PostRow {
    
    var _header: some View {
        HStack {
            HStack(spacing: 9.0) {
                Button {
                    vm.toggleNavigateProfileView()
                } label: {
                    CircleAvatar(imageUrl: vm.post.user!.avatarUrl, radius: 40)
                    VStack(alignment: .leading) {
                        Text(vm.post.user!.fullName)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Text("@\(vm.post.user!.username)")
                            .font(.caption)
                            .fontWeight(.light)
                    }
                }
            }
            
            Spacer()
            Menu {
                if vm.post.uid == FirebaseManager.shared.auth.currentUser?.uid {
                    PostOptionView(
                        isShowEditPost: $vm.isShowEditPost,
                        isShowDeletePostAlert: $vm.isShowDeletePostAlert)
                } else {
                    VStack {
                        Button {
                            vm.downloadImage(fromUrl: vm.post.imagesUrl[_imageSelectionIndex]) { isSuccess in
                                if isSuccess {
                                    withAnimation {
                                        homeVm.isShowToast.toggle()
                                    }
                                }
                            }
                            
                        } label: {
                            HStack(alignment: .center, spacing: 15){
                                Image(systemName: "arrow.down.to.line.compact")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 24, height: 24)
                                Text("Save")
                                    .font(.system(size: 17, weight: .regular))
                            }
                        }
                    }
                }
            } label: {
                Image.icnMore
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .rotationEffect(Angle(degrees: 90))
            }
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.bottom, 8)
    }
    
    var _content: some View {
        VStack {
            SquareImageTab(imagesUrl: vm.post.imagesUrl, currentStep: $_imageSelectionIndex)
            
            HStack {
                HStack(spacing: 10.0) {
                    Button {
                        Task {
                            await vm.handleLikePost()
                        }
                    } label: {
                        if vm.didLike {
                            Image.icnHeartBold
                                .renderingMode(.template)
                                .foregroundColor(Color.red)
                        } else {
                            Image.icnHeart
                                .renderingMode(.template)
                                .foregroundColor(Color.primary)
                        }
                    }
                    
                    IconButton(imageIcon: Image.icnComment) {
                        vm.toggleNavigateCommentView()
                    }
                    
                    IconButton(imageIcon: Image.icnShare) {
                        vm.onMessage()
                    }
                    
                }
                
                if(vm.imageCount > 1) {
                    ImageTabIndicator(tabCount: vm.imageCount, activeIndex: $_imageSelectionIndex)
                        .padding(.leading, 60)
                }
                
                Spacer()
                
                IconButton(imageIcon: Image.icnBookmark) {
                    vm.onShare()
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
        }
    }
    
    var _caption: some View {
        Text(vm.post.caption)
            .font(.footnote)
            .padding(.top, 8)
            .padding(.horizontal, AppStyle.defaultSpacing)
    }
    
    var _showAllCommentButton: some View {
        Button {
            vm.showAllComment()
        } label: {
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
                else {
                    UserRowShimmer().circleAvatar(radius: 30)
                }
                GeometryReader { proxy in
                    Button {
                        vm.toggleNavigateCommentView()
                    } label: {
                        Text("Add comment")
                            .font(.footnote)
                            .foregroundColor(Color.semiText)
                            .frame(width: proxy.size.width,
                                   height: proxy.size.height,
                                   alignment: .leading)
                    }
                }
            }
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.top, 12)
    }
    
    var _postTime: some View {
        Text(vm.post.getTimePostAgo())
            .font(.system(.caption))
            .foregroundColor(Color.semiText)
            .padding(.horizontal, AppStyle.defaultSpacing)
            .padding(.top, 5)
    }
}

extension URL {
    func saveImage(_ image: UIImage?) {
        if let image = image {
            if let data = image.jpegData(compressionQuality: 1.0) {
                try? data.write(to: self)
            }
        } else {
            try? FileManager.default.removeItem(at: self)
        }
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
