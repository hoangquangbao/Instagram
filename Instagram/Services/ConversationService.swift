//
//  ConversationService.swift
//  Instagram
//
//  Created by lhduc on 06/01/2023.
//

import Foundation

class ConversationService {
//    typealias ModelType = Conversation
    
    static let shared = ConversationService()
    
    let _conversationRef = FirebaseManager.shared.firestore.collection(FirebaseConstants.CONVERSATION_COLLECTION)
    
    func getAll(uid: String, completion: @escaping ([Conversation]) -> Void) {
        _conversationRef.addSnapshotListener { querySnapshot, error in
            guard let querySnapshot = querySnapshot else {
                print(error?.localizedDescription as Any)
                return
            }
            
            let conversations = querySnapshot.documents.compactMap{ try? $0.data(as: Conversation.self) }
            let myConversations = conversations.filter{ $0.user1.id == uid || $0.user2.id == uid }
            
            completion(myConversations)
        }
    }
    
//    static func get(by id: String) async throws -> Conversation? {
//
//    }
//
//    static func getAll(completion: @escaping ([Conversation]) -> Void) {
//
//    }
//
//    static func create(_: Conversation, completion: @escaping (Bool, Error?) -> Void) {
//
//    }
//
//
//    static func update(with id: String, field: String, data: Any, completion: @escaping (Bool, Error?) -> Void) {
//
//    }
//
//    static func delete(with id: String, completion: @escaping (Bool, Error?) -> Void) {
//
//    }
    
    
    
    
}
