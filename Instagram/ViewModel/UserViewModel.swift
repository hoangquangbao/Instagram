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
    
    init() {
        Task {
            self.isFetching = true
            await refresh()
        }
    }
    
    @MainActor func refresh() async {
        do {
            self.users = try await UserService.getAll()
            self.isFetching = false
        } catch {
            self.isFetching = false
        }
    }
    
    var userHasStory: [User] {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return [] }
        return users.filter { $0.hasStory == true && $0.id != uid}
    }
    
    func searchableUser(_ text: String) -> [User] {
        if(text.isEmpty) { return users }
        
        return users.filter { user in
            user.username.contains(text) || user.fullName.contains(text)
        }
    }
}
