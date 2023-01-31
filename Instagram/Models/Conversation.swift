//
//  Conversation.swift
//  Instagram
//
//  Created by lhduc on 05/01/2023.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Conversation: Identifiable, Encodable, Decodable {
    @DocumentID var id: String?
//    let uid1: String
//    let uid2: String
    
//    let user1: User
//    let user2: User
    let participants: [User]
    var lastMessageTimestamp = Timestamp(date: Date())
    var messages: [Message]?
}
