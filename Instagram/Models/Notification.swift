//
//  Notification.swift
//  Instagram
//
//  Created by lhduc on 17/11/2022.
//

import Firebase
import FirebaseFirestoreSwift

struct Notification: Identifiable, Encodable, Decodable {
    var id: String = UUID().uuidString
    let uid: String
    let action: NotificationAction
    let type: NotificationType
    let referenceId: String
    let userInteractionId: String
    let content: String
    var isRead: Bool = false
    var notifyAt: Timestamp = Timestamp(date: Date())
    
    var user: User?
    var userInteraction: User?
    var post: Post?
}

extension Notification {
    func getTimeNotifyAgo() -> String {
        return TimestampHelper.getTimeAgo(timestamp: self.notifyAt)
    }
}

enum NotificationAction: String, Decodable, Encodable {
    case like, comment, tag
}

enum NotificationType: String, Decodable, Encodable {
    case post, story, follow, flollowing
}
