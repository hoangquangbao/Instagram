//
//  SessionViewModel.swift
//  Instagram
//
//  Created by lhduc on 31/10/2022.
//

import SwiftUI
import FirebaseAuth

enum SessionState {
    case loggedIn, loggedOut
}

class SessionViewModel: ObservableObject {
    private let userService = UserService()
    
    @Published var userSession: SessionState = .loggedOut
    @Published var userInfo: User?
    
    init() {
        if(UserDefaults.standard.isLoggedIn()) {
            LocalStorage.retrieve(forKey: StorageKey.USER_INFO) { user in
                self.userInfo = user
            }
            
            refresh()
        }
    }
    
    func refresh() {
        guard let uid = self.userInfo?.id else { return }
        userService.get(by: uid) { user in
            self.userInfo = user
            
            LocalStorage.store(with: user, forKey: StorageKey.USER_INFO)
        }
    }
    
    var uid: String {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return "" }
        return uid
    }
}

