//
//  UserViewModel.swift
//  Instagram
//
//  Created by lhduc on 02/11/2022.
//

import SwiftUI

class UserViewModel: ObservableObject {
    var isFetching: Bool = false
    @Published var users: [User] = []
    
    private let userService  = UserService()
    private let storyService = StoryService()
    
    init() {
        refresh()
    }
    
    func refresh() {
        self.isFetching.toggle()
        
        self.userService.getAll { users in
            self.users = users
            
            self.isFetching.toggle()
        }
    }
    
    var userHasStory: [User] {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return [] }
        return users.filter { $0.hasStory == true && $0.id != uid}
    }
}
