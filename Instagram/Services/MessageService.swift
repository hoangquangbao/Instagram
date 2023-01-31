//
//  MessageService.swift
//  Instagram
//
//  Created by lhduc on 30/01/2023.
//

import Foundation

struct MessageService {
    static let shared = MessageService()
    private let db = FirebaseManager.shared.firestore
    
    func getAll(conversationId: String, completion: @escaping ([Message]) -> Void) {
        db.collection(FirebaseConstants.CONVERSATION_COLLECTION)
            .document(conversationId)
            .collection(FirebaseConstants.MESSAGE_COLLECTION)
            .order(by: "sendAt")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching messages: \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                guard let querySnapshot = querySnapshot else {
                    completion([])
                    return
                }
                
                let messages = querySnapshot.documents.compactMap { try? $0.data(as: Message.self)}
                
                completion(messages)
            }
    }
    
    
    func create(_ message: Message, conversationId: String, completion: @escaping (Bool, Error?) -> Void) {
        do {
            try db
                .collection(FirebaseConstants.CONVERSATION_COLLECTION)
                .document(conversationId)
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
