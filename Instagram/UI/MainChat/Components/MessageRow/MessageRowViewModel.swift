//
//  MessageRowViewModel.swift
//  Instagram
//
//  Created by lhduc on 11/01/2023.
//

import Foundation

class MessageRowViewModel: ObservableObject {
    @Published var conversation: Conversation
    
    init(_ conversation: Conversation) {
        self.conversation = conversation
        self.participant = getParticipant()
    }
    
    var participant: User?
    var lastMessage: Message? { return conversation.messages?.last }
    var isNotSeen: Bool {
        return lastMessage?.hasSeen == false && isNotSender(lastMessage)
    }
    
    func getParticipant() -> User? {
        guard let currentUid = FirebaseManager.shared.auth.currentUser?.uid else { return nil }
        
        let participant = ConversationHelper.getParticipant(of: currentUid, in: conversation)
        
        return participant
    }
    
    func isSender(_ message: Message?) -> Bool {
        guard let message = message else { return false }
        guard let currentUid = FirebaseManager.shared.auth.currentUser?.uid else { return false }
        return message.senderId == currentUid
    }
    
    func isNotSender(_ message: Message?) -> Bool {
        return !isSender(message)
    }
}
