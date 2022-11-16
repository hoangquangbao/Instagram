//
//  PostRowViewModel.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//
import SwiftUI
import Firebase

@MainActor
class PostRowViewModel: ObservableObject {
    @Published var post: Post
    @Published var isNavigateProfileView: Int? = nil
    @Published var isNavigateCommentView: Int? = nil
    @Published var commentText: String = ""
    
    init(post: Post) {
        self.post = post
//        Task {
//            await getLatestUserLikePost()
//        }
    }
    
    var imageSelectionIndex = 0
    var imageCount  : Int   { return post.imagesUrl.count }
    var likeCount   : Int   { return post.likeCount }
    var commentCount: Int   { return post.commentCount }
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
    
    func handleLikePost() async {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let postId = post.id else { return }
        
        if post.likes.contains(uid) {
            post.likes = post.likes.filter { $0 != uid }
            await _updateLikePost(with: postId, likes: post.likes)
            
        } else {
            post.likes.append(uid)
            await _updateLikePost(with: postId, likes: post.likes)
        }
    }
    
    func _updateLikePost(with id: String, likes: [String]) async {
        PostService.update(with: id, field: "likes", data: likes) { [self] isSuccess, error in
            if error != nil { return }
            
            Task {
                guard let _posts = try await PostService.get(by: id) else { return }
                self.post = _posts
                
                await getLatestUserLikePost()
            }
        }
    }
    
    func getLatestUserLikePost() async {
        if post.likeCount <= 0 { return }
        do {
            let latestUid = post.likes[post.likeCount - 1]
            self.post.latestUserLikePost = try await UserService.get(by: latestUid)
        }
        catch {
            
        }
    }
    
    func createComment() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let postId = post.id else { return }
        let comment = Comment(uid: uid, comment: commentText)
        self.commentText = ""
        
        PostService.update(with: postId, comment: comment) { [self] isSuccess, error in
            if error != nil { return }

            _increaseCommentCount(with: postId) {
                Task {
                    await self.loadComment()
                }
            }
        }
    }
    
    func _increaseCommentCount(with postId: String, completion: @escaping () -> Void) {
        let data = FieldValue.increment(1.0)
        PostService.update( with: postId, field: "commentCount", data: data) { isSuccess, _ in
            if !isSuccess { return }
            
            completion()
        }
    }
    
    func loadComment() async {
        guard let postId = post.id else { return }
        
        do {
            self.post.comments = try await PostService.getComments(with: postId)
        } catch {
            
        }
    }
}
