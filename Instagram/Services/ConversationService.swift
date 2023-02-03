//
//  ConversationService.swift
//  Instagram
//
//  Created by lhduc on 06/01/2023.
//

import Foundation
import Firebase

class ConversationService {
    static let shared = ConversationService()
    private let db = FirebaseManager.shared.firestore
    
    func getAll(uid: String, completion: @escaping ([Conversation]) -> Void) {
        let conversationsRef = db.collection(FirebaseConstants.CONVERSATION_COLLECTION)
        conversationsRef
            .order(by: "lastMessageTimestamp", descending: true)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching conversations: \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                guard let querySnapshot = querySnapshot else {
                    completion([])
                    return
                }
                
                var conversations = querySnapshot.documents
                    .compactMap { try? $0.data(as: Conversation.self) }
                    .filter { $0.participants.contains { $0.uid == uid} }
                
                for i in 0..<conversations.count {
                    MessageService.shared.getAll(conversationId: conversations[i].id!) { messages in
                        
                        conversations[i].messages = messages
                        conversations[i].lastMessageTimestamp = messages.last?.sendAt ?? Timestamp(date: Date())
                        
                        completion(conversations)
                    }
                }
            }
    }
    
    func get(by id: String) async throws -> Conversation? {
        let result = try? await db
            .collection(FirebaseConstants.CONVERSATION_COLLECTION)
            .document(id)
            .getDocument()
            .data(as: Conversation.self)
        
        return result
    }
    
    func create(_ conversation: Conversation, completion: @escaping (Bool, Error?) -> Void) {
        let uid1 = conversation.participants[0].uid
        let uid2 = conversation.participants[1].uid
        let conversationId = ConversationHelper.getId(uid1, uid2)
        do {
            try db
                .collection(FirebaseConstants.CONVERSATION_COLLECTION)
                .document(conversationId)
                .setData(from: conversation) { error in
                    if let error = error {
                        completion(false, error)
                    }
                    else {
                        completion(true, nil)
                    }
                }
        } catch {
            completion(false, error)
        }
    }
    
    //
    //
    //    static func update(with id: String, field: String, data: Any, completion: @escaping (Bool, Error?) -> Void) {
    //
    //    }
    //
    //    static func delete(with id: String, completion: @escaping (Bool, Error?) -> Void) {
    //
    //    }
    
    func sendMessage(_ message: Message, in conversation: Conversation, completion: @escaping (Bool, Error?) -> Void) {
        
        var conversationId = conversation.id
        
        if conversationId == nil {
            create(conversation) { success, _ in
                if !success {
                    return
                }
            }
            conversationId = ConversationHelper.getId(conversation.participants[0].uid, conversation.participants[1].uid)
        }
        
        do {
            try db
                .collection(FirebaseConstants.CONVERSATION_COLLECTION)
                .document(conversationId!)
                .collection(FirebaseConstants.MESSAGE_COLLECTION)
                .document()
                .setData(from: message) { error in
                    if let error = error {
                        completion(false, error)
                    }
                    else {
                        completion(true, nil)
                    }
                }
        } catch {
            completion(false, error)
        }
    }  
}
