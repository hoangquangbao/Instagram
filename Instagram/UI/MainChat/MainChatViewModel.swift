//
//  MainChatViewModel.swift
//  Instagram
//
//  Created by lhduc on 06/01/2023.
//

import Foundation

class MainChatViewModel: ObservableObject {
    var conversations: [Conversation] = []
    
    init() {
        fetchConversations()
    }
    
    func fetchConversations() {
//        guard let currentUid = FirebaseManager.shared.auth.currentUser?.uid else { return }
//
//        ConversationService.shared.getAll(uid: currentUid) { conversations in
//            self.conversations = conversations
//        }
        
        self.conversations = MockData.conversations
    }
}
