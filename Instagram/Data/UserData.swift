//
//  UserData.swift
//  Instagram
//
//  Created by lhduc on 02/11/2022.
//

import SwiftUI

class UserData: ObservableObject {
    @Published var users: [User] = []
    private let userService = UserService()
    
    func refresh() {
        userService.getAll { users in
            self.users = users
        }
    }
    
    var usersHasStory: [User] {
        return self.users.filter { user in
            return user.hasStory == true
        }
    }
}

