//
//  UserViewModel.swift
//  Instagram
//
//  Created by lhduc on 02/11/2022.
//

import SwiftUI

@MainActor class UserViewModel: ObservableObject {
    var isFetching: Bool = false
    @Published var users: [User] = []
    @Published var userHasStory: [User] = []
    
    init() {
        self.isFetching = true
        getAll()
    }
    
    func getAll() {
        UserService.getAll { users in
            self.users = users
            self.isFetching = false
            self.getUserHasStory()
        }
    }
    
    func getUserHasStory() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        self.userHasStory = users.filter { $0.hasStory == true && $0.id != uid}
    }
    
    func searchableUser(_ text: String) -> [User] {
        if(text.isEmpty) { return users }
        
        return users.filter { user in
            user.username.contains(text) || user.fullName.contains(text)
        }
    }
}
