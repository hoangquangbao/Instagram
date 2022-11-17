//
//  NotificationService.swift
//  Instagram
//
//  Created by lhduc on 17/11/2022.
//

import Firebase

struct NotificationService: ServiceProtocol {
    typealias ModelType = Notification
    static private let _notificationRef = FirebaseManager.shared.firestore.collection(FirebaseConstants.NOTIFICATION_COLLECTION)
    
    static func get(by id: String) async throws -> Notification? {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return nil }
        
        let ownCollection = _notificationRef.document(uid).collection(FirebaseConstants.NOTIFICATION_COLLECTION)
        let notification = try? await ownCollection.document(id).getDocument().data(as: Notification.self)
        
        return notification
    }
    
    static func getAll() async throws -> [Notification] {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return [] }
        
        let ownCollection = _notificationRef.document(uid).collection(FirebaseConstants.NOTIFICATION_COLLECTION)
        let documents = try await ownCollection.order(by: "notifyAt", descending: true).getDocuments().documents
        var notifications = documents.compactMap { try? $0.data(as: Notification.self) }
        
        for i in 0..<notifications.count {
            notifications[i].user = try await UserService.get(by: notifications[i].uid)
            notifications[i].userInteraction = try await UserService.get(by: notifications[i].userInteractionId)
            notifications[i].post = try await PostService.get(by: notifications[i].referenceId)
        }
        
        return notifications
    }
    
    static func getUnReadCount() async throws -> Int? {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return nil }
        return try? await _notificationRef.document(uid).getDocument().data()?["unReadCount"] as? Int
    }
    
    static func create(_ notification: Notification, completion: @escaping (Bool, Error?) -> Void) {
        do {
            let ownDocument = _notificationRef.document(notification.uid)
            let subNotifRef = ownDocument.collection(FirebaseConstants.NOTIFICATION_COLLECTION)
            
            NotificationService.update(with: notification.uid, field: "unReadCount", data: FieldValue.increment(1.0)) { isSuccess, error in
                if !isSuccess {
                    ownDocument.setData(["unReadCount": 1]) { error in
                        
                        completion(false, error)
                        return
                    }
                }
            }
            
            try subNotifRef
                .document(notification.id)
                .setData(from: notification) { error in
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
    
    static func update(with id: String, field: String, data: Any, completion: @escaping (Bool, Error?) -> Void) {
        _notificationRef.document(id).updateData([field: data]) { error in
            if let error = error {
                completion(false, error)
                return
            }
            
            completion(true, nil)
        }
    }
    
    static func delete(with id: String, completion: @escaping (Bool, Error?) -> Void) {
        return
    }
    
    
}
