//
//  ConversationHelper.swift
//  Instagram
//
//  Created by lhduc on 06/01/2023.
//

import Foundation

struct ConversationHelper {
    static func getId(_ firstUserId: String, _ secondUserId: String) -> String {
        let userIdArr = [firstUserId, secondUserId].sorted()
        
        return "\(userIdArr[0])-\(userIdArr[1])"
    }
    
    static func getIndex(of currentUid: String, in conversationId: String) -> Int {
        let uidArr = conversationId.components(separatedBy: "-")
        
        guard let index = uidArr.firstIndex(of: currentUid) else { return 0 }
        return index
    }
    
    static func getParticipant(with currentUid: String, in conversation: Conversation) -> User {
        if currentUid == conversation.user1.id {
            return conversation.user2
        }
        
        return conversation.user1
    }
}
