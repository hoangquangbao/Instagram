//
//  Story.swift
//  Instagram
//
//  Created by lhduc on 02/11/2022.
//

import Foundation

import FirebaseFirestoreSwift
import Firebase

struct Story: Identifiable, Decodable, Encodable {
    @DocumentID var id: String?
    let uid: String
    let caption: String
    var imagesUrl: String
    var likes: [User] = []
    var createAt: Timestamp = Timestamp(date: Date())
    
    var user: User?
    var didLike: Bool = false
    var likeCount: Int { return likes.count }
}

extension Story {
    func getTimePostAgo() -> String {
        return self.createAt.dateValue().timeAgoDisplay()
    }
}

