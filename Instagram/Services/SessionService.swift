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

class SessionService: ObservableObject {
    @Published var userSession: SessionState = .loggedOut
    @Published var currentUser: User?
}

