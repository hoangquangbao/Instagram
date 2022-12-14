//
//  NotificationService.swift
//  Instagram
//
//  Created by lhduc on 17/11/2022.
//

import Firebase

struct NotificationService {
    static private let _notificationRef = FirebaseManager.shared.firestore.collection(FirebaseConstants.NOTIFICATION_COLLECTION)
    
    static func getAll(completion: @escaping ([Notification]) -> Void) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let ownRef = _notificationRef.document(uid).collection(FirebaseConstants.NOTIFICATION_COLLECTION)
        ownRef.order(by: "notifyAt", descending: true).addSnapshotListener { snapshot, error in
            Task {
                guard let documents = snapshot?.documents else { completion([]); return }
                var notifications = documents.compactMap { try? $0.data(as: Notification.self) }
                
                print(notifications)
                
                for i in 0..<notifications.count {
                    notifications[i].user = try await UserService.get(by: notifications[i].uid)
                    notifications[i].userInteraction = try await UserService.get(by: notifications[i].userInteractionId)
                    notifications[i].post = try await PostService.get(by: notifications[i].referenceId)
                }
                
                completion(notifications)
                
            }
        }
    }
    
    static func getUnReadCount(completion: @escaping (Int) -> Void) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        _notificationRef.document(uid).addSnapshotListener { snapshot, error in
            guard let document = snapshot?.data() else {
                print("no notification")
                completion(0)
                return
            }
            
            completion(document["unReadCount"] as! Int)
        }
        
    }
    
    static func create(_ notification: Notification, completion: @escaping (Bool, Error?) -> Void) {
        do {
            let ownDocument = _notificationRef.document(notification.uid)
            let subNotifRef = ownDocument.collection(FirebaseConstants.NOTIFICATION_COLLECTION)
            
            NotificationService.updateUnReadCount(of: notification.uid, data: FieldValue.increment(1.0)) { isSuccess, error in
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
        }
        catch {
            completion(false, error)
        }
    }
    
    static func createIfExist(_ notification: Notification, completion: @escaping (Bool, Error?) -> Void) {
        let ownDocument = _notificationRef.document(notification.uid)
        let subNotifRef = ownDocument.collection(FirebaseConstants.NOTIFICATION_COLLECTION)
        
        NotificationService._getExistNotification(of: notification) { existNotif in
            guard let existNotif = existNotif else {
                do {
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
                } catch { completion(false, error) }
                return
            }
            
            NotificationService.update(of: existNotif.uid, with: existNotif.id, field: "isRead", data: false) { isSuccess, _ in
                if isSuccess {
                    NotificationService.update(of: existNotif.uid, with: existNotif.id, field: "notifyAt", data: Date()) { _, __ in
                    }
                }
            }
            
            if existNotif.isRead {
                NotificationService.updateUnReadCount(of: existNotif.uid, data: FieldValue.increment(1.0)) { isSuccess, error in
                    if !isSuccess {
                        ownDocument.setData(["unReadCount": 1]) { error in
                            completion(false, error)
                            return
                        }
                    }
                }
            }
        }
    }
    
    static func update(of uid: String, with id: String, field: String, data: Any, completion: @escaping (Bool, Error?) -> Void) {
        let subNotifRef =  _notificationRef.document(uid).collection(FirebaseConstants.NOTIFICATION_COLLECTION)
        
        subNotifRef.document(id).updateData([field: data]) { error in
            if let error = error {
                completion(false, error)
                return
            }
            
            completion(true, nil)
        }
    }
    
    static func updateUnReadCount(of uid: String, data: Any, completion: @escaping (Bool, Error?) -> Void) {
        _notificationRef.document(uid).updateData(["unReadCount": data]) { error in
            if let error = error {
                completion(false, error)
                return
            }
            
            completion(true, nil)
        }
    }
    
    static private func _getExistNotification(of notification: Notification, completion: @escaping (Notification?) -> Void
    ) {
        
        let subNotifRef =  _notificationRef.document(notification.uid).collection(FirebaseConstants.NOTIFICATION_COLLECTION)
        subNotifRef
            .whereField("referenceId", isEqualTo: notification.referenceId)
            .whereField("userInteractionId", isEqualTo: notification.userInteractionId)
            .whereField("action", isEqualTo: notification.action.rawValue)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let notifications = documents.compactMap { try? $0.data(as: Notification.self) }
                
                print(notifications)
                
                completion(notifications.isNotEmpty ? notifications[0] : nil)
            }
    }
    
    static func delete(with id: String, completion: @escaping (Bool, Error?) -> Void) {
        return
    }
}
