//
//  PostViewModel.swift
//  Instagram
//
//  Created by lhduc on 02/11/2022.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private let postService = PostService()
    private let userService = UserService()
    
    init() {
        refresh()
    }
    
    func refresh() {
        postService.getAll { posts in
            self.posts = posts
            
            for i in 0..<posts.count {
                self.userService.get(by: posts[i].uid) { user in
                    self.posts[i].user = user
                }
            }
        }
    }
    
    func getNotOwningPost() -> [Post] {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return [] }
        return posts.filter{ $0.uid != uid  }
    }
    
    func getOwningPost(withUid uid: String) -> [Post] {
        return posts.filter{ $0.uid == uid  }
    }
}
