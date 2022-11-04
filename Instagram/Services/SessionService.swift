//
//  SessionService.swift
//  Instagram
//
//  Created by lhduc on 31/10/2022.
//

import SwiftUI
import FirebaseAuth

enum SessionState {
    case loggedIn, loggedOut
}

@MainActor class SessionService: ObservableObject {
    @Published var userSession: SessionState = .loggedOut
    @Published var userInfo: User?
    
    init() {
        if(UserDefaults.standard.isLoggedIn()) {
            LocalStorage<User>.retrieve(forKey: StorageKey.USER_INFO) { user in
                self.userInfo = user
            }
        }
    }
}

