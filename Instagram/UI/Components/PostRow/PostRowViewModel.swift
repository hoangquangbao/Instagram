//
//  PostRowViewModel.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//
import SwiftUI
import Firebase

class PostRowViewModel: ObservableObject {
    private let postService = PostService()
    private let userService = UserService()
    
    @Published var post: Post
    @Published var isNavigateProfileView: Int? = nil
    @Published var isNavigateCommentView: Int? = nil
    @Published var latestUserLikePost: User?
    @Published var commentText: String = ""
    
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
    
    func toggleNavigateProfileView() {
        self.isNavigateProfileView = 1
    }
    
    func toggleNavigateCommentView() {
        self.isNavigateCommentView = 1
    }
    
    func showAllComment() {
        print("All comment have been displayed")
    }
    
    func onFavorite() {
        print("favorite")
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
    
    func createComment() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let postId = post.id else { return }
        let comment = Comment(uid: uid, comment: commentText)
        self.commentText = ""
        
        postService.update(with: postId, comment: comment) { [self] isSuccess, error in
            if error != nil { return }

            _increaseCommentCount(with: postId) {
                self.loadComment()
            }
        }
    }
    
    func _increaseCommentCount(with postId: String, completion: @escaping () -> Void) {
        let data = FieldValue.increment(1.0)
        postService.update( with: postId, field: "commentCount", data: data) { isSuccess, _ in
            if !isSuccess { return }
            
            completion()
        }
    }
    
    func loadComment() {
        guard let postId = post.id else { return }
        
        postService.getComments(by: postId) { [self] comments in
            self.post.comments = comments
            
            for i in 0..<comments.count {
                userService.get(by: comments[i].uid) { user in
                    self.post.comments?[i].user = user
                }
            }
        }
    }
}
