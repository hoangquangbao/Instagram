//
//  HomeViewModel.swift
//  Instagram
//
//  Created by lhduc on 15/10/2022.
//

import Foundation
class HomeViewModel: ObservableObject {
    var posts = [Post]()
    var users = [User]()
    let currentUser = FirebaseManager.shared.auth.currentUser
    
    let postService = PostService()
    let userService = UserService()
    
    
    init() {
        fetchPosts()
        fetchUsers()
    }
    
    func fetchPosts() {
        postService.getAll { posts in
            self.posts = posts
        }
    }
    
    func fetchUsers() {
        userService.getAll { users in
            self.users = users
        }
    }
    
    func navigateMessageView() {
        print("navigate to Message View")
    }
}
