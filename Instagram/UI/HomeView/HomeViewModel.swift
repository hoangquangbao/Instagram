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
    
    let postService = PostService()
    let userService = UserService()
    
    @Published var isShowNewPostView: Bool = false
    @Published var isShowNewStoryView: Bool = false
    
    
    init() {
        fetchUsers()
        fetchPosts()
    }
    
    func fetchPosts() {
        postService.getAll { posts in
            self.posts = posts
            
            for i in 0..<posts.count {
                self.userService.get(by: posts[i].uid) { user in
                    self.posts[i].user = user
                }
            }
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
