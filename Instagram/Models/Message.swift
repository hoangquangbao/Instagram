//
//  Message.swift
//  Instagram
//
//  Created by lhduc on 05/01/2023.
//

import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable, Encodable, Decodable {
    @DocumentID var id: String?
    let senderId: String
    let text: String
    var hasSeen: Bool = false
    var sendAt: Timestamp = Timestamp(date: Date())
}

extension Message {
    var sendAtAgo: String {
        return TimestampHelper.getTimeAgo(timestamp: self.sendAt)
    }
}

// Update user info

//db.collection("messages")
//  .where("sender.id", "==", "123")
//  .get()
//  .then(querySnapshot => {
//    querySnapshot.forEach(doc => {
//      doc.ref.update({
//        "sender.name": "John Smith",
//        "sender.email": "john@example.com"
//      });
//    });
//  });


