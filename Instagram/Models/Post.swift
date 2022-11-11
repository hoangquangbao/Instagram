//
//  Post.swift
//  Instagram
//
//  Created by lhduc on 14/10/2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Decodable, Encodable {
    @DocumentID var id: String?
    let uid: String
    let caption: String
    var imagesUrl: [String]
    var categories: [String] = []
    var likes: [String] = []
    var commentCount: Int = 0
    var createAt: Timestamp = Timestamp(date: Date())
    
    var user: User?
    var comments: [Comment]?
    var didLike: Bool = false
    var likeCount: Int { return likes.count }
}

extension Post {
    func getTimePostAgo() -> String {
        return self.createAt.dateValue().timeAgoDisplay()
    }
}
