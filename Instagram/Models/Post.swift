//
//  Post.swift
//  Instagram
//
//  Created by lhduc on 14/10/2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Decodable, Equatable {
    @DocumentID var id: String?
    let uid: String
    let caption: String
    var imagesUrl: [String]
    var categories: [String]
    var likes: Int = 0
    var timestamp: Timestamp = Timestamp(date: Date())
    
    var user: User?
    var didLike: Bool = false
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.uid == rhs.uid
    }
    
    
    func getTimePostAgo() -> String {
        return self.timestamp.dateValue().timeAgoDisplay()
    }
}
