//
//  Story.swift
//  Instagram
//
//  Created by lhduc on 02/11/2022.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct Story: Identifiable, Decodable, Encodable {
    @DocumentID var id: String?
    let uid: String
    let caption: String
    var imagesUrl: String
    var captionColorHex: String = "000000"
    var textAlignment: String = "bottom"
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
    
    func getTextAlignment() -> Alignment {
        switch self.textAlignment {
            case "center": return Alignment.center
            case "bottom": return Alignment.bottom
            default:       return Alignment.bottom
            
        }
    }
}

