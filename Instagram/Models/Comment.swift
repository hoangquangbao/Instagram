//
//  Comment.swift
//  Instagram
//
//  Created by lhduc on 11/11/2022.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct Comment: Identifiable, Decodable, Encodable {
    var id: String = UUID().uuidString
    let uid: String
    let comment: String
    var likes: [String] = []
    var commentAt: Timestamp = Timestamp(date: Date())
    
    var user: User?
}
