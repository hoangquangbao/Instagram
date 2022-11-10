//
//  File.swift
//  Instagram
//
//  Created by lhduc on 10/11/2022.
//

import Foundation

class CommentViewModel: ObservableObject {
    @Published var post: Post?
    var currentUser: User?
    private let postService = PostService()
    
    func setup(post: Post, currentUser: User?) {
        self.post = post
        self.currentUser = currentUser
    }
    
    func handleLike() {
        guard var post = post else { return }
        guard let id = self.post!.id else { return }
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        if post.likes.contains(uid) {
            post.likes = post.likes.filter { $0 != uid }
            _updateLike(with: id, likes: post.likes)
            
        } else {
            post.likes.append(uid)
            _updateLike(with: id, likes: post.likes)
        }
    }
    
    func _updateLike(with id: String, likes: [String]) {
        postService.update(with: id, field: "likes", data: likes) { [self] isSuccess, error in
            if error != nil { return }
            
            postService.get(by: id) { _post in
                self.post = _post
            }
        }
    }
}
