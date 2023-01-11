//
//  Conversation.swift
//  Instagram
//
//  Created by lhduc on 05/01/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Conversation: Identifiable, Encodable, Decodable {
    @DocumentID var id: String?
    let user1: User
    let user2: User
    
    let messages: [Message]
}
