//
//  PostViewModel.swift
//  Instagram
//
//  Created by lhduc on 02/11/2022.
//

import Foundation

@MainActor class PostViewModel: ObservableObject {
    var isFetching: Bool = false
    @Published var posts: [Post] = []
    
    init() {
        refresh()
    }
    
    func refresh() {
        Task {
            self.isFetching.toggle()
            do {
                self.posts = try await PostService.getAll()
                self.isFetching.toggle()
            } catch {
                self.isFetching.toggle()
            }
        }
    }
    
    func getNotOwningPost() -> [Post] {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return [] }
        return posts.filter{ $0.uid != uid  }
    }
    
    func getOwningPost(of user: User) -> [Post] {
        guard let uid = user.id else { return [] }
        return posts.filter { $0.uid == uid  }
    }
}
