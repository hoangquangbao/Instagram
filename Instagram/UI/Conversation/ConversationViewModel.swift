//
//  ConversationViewModel.swift
//  Instagram
//
//  Created by lhduc on 11/01/2023.
//

import Foundation

class ConversationViewModel: ObservableObject {
    @Published var conversation: Conversation
    
    init(_ conversation: Conversation) {
        self.conversation = conversation
        self.participant = getParticipant()
    }
    
    @Published var participant: User?
    @Published var messageText: String = ""
    
    func getParticipant() -> User? {
        guard let currentUid = FirebaseManager.shared.auth.currentUser?.uid else { return MockData.users[1] }
        
        let participant = ConversationHelper.getParticipant(with: currentUid, in: conversation)
        
        return participant
    }
}
