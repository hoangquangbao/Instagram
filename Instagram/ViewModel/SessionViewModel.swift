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

@MainActor class SessionViewModel: ObservableObject {
    @Published var userSession: SessionState = .loggedOut
    @Published var userInfo: User!
    
    init() {
        if(UserDefaults.standard.isLoggedIn()) {
            let currentUser: User? = LocalStorage.retrieve(forKey: StorageKey.USER_INFO)
            guard let currentUser = currentUser else {
                return
            }
            
            self.userInfo = currentUser
            
            Task {
                await refresh()
            }
        }
    }
    
    @MainActor func refresh() async {
        do {
            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
            self.userInfo = try await UserService.get(by: uid)
            LocalStorage.store(with: userInfo, forKey: StorageKey.USER_INFO)
        } catch {
            
        }
    }
    
    var uid: String {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return "" }
        return uid
    }
}

