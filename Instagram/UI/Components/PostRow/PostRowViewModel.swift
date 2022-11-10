//
//  PostRowViewModel.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//
import SwiftUI

class PostRowViewModel: ObservableObject {
    private let postService = PostService()
    private let userService = UserService()
    
    @Published var post: Post
    @Published var isNavigateProfileView: Int? = nil
    @Published var latestUserLikePost: User?
    
    init(post: Post) {
        self.post = post
        getLatestUserLikePost()
    }
    
    var imageSelectionIndex = 0
    var imageCount        : Int   { return post.imagesUrl.count }
    var likeCount         : Int   { return post.likeCount }
    var commentCount      : Int   { return post.commentCount }
    var didLike: Bool {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return false}
        return post.likes.contains(uid)
    }
    
    func toggleNavigate() {
        self.isNavigateProfileView = 1
    }
    
    func showAllComment() {
        print("All comment have been displayed")
    }
    
    func onFavorite() {
        print("favorite")
    }
    
    func onComment() {
        print("comment")
    }
    
    func onMessage() {
        print("message")
    }
    
    func onShare() {
        print("share")
    }
    
    func getLatestUserLikePost() {
        if post.likeCount <= 0 { return }
        userService.get(by: post.likes[post.likeCount - 1]) { user in
            self.latestUserLikePost = user
        }
    }
    
    func handleLikePost() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let postId = post.id else { return }
        
        if post.likes.contains(uid) {
            post.likes = post.likes.filter { $0 != uid }
            _updateLikePost(with: postId, likes: post.likes)
            
        } else {
            post.likes.append(uid)
            _updateLikePost(with: postId, likes: post.likes)
        }
    }
    
    func _updateLikePost(with id: String, likes: [String]) {
        postService.update(with: id, field: "likes", data: likes) { [self] isSuccess, error in
            if error != nil { return }
            
            postService.get(by: id) { [self] _post in
                self.post.likes = _post.likes
            }
            
            getLatestUserLikePost()
        }
    }
}
