//
//  User.swift
//  Instagram
//
//  Created by lhduc on 13/10/2022.
//
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable, Encodable {
    @DocumentID var id: String?
    var uid: String = UUID().uuidString
    let email: String
    let username: String
    let fullName: String
    let avatarUrl: String
    var description: String = ""
    var hasStory: Bool = false
    var isOnline: Bool = false
    var followings: [User] = []
    var followers: [User] = []
}
