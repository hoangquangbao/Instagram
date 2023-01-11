//
//  ConversationViewModel.swift
//  Instagram
//
//  Created by lhduc on 11/01/2023.
//

import Foundation

class ConversationViewModel: ObservableObject {
    @Published var conversation: Conversation
    var participant: User?
    
    init(_ conversation: Conversation) {
        self.conversation = conversation
        self.participant = getParticipant()
    }
    
    func getParticipant() -> User? {
        guard let currentUid = FirebaseManager.shared.auth.currentUser?.uid else { return nil }
        
        let participant = ConversationHelper.getParticipant(with: currentUid, in: conversation)
        
        return participant
    }
}
