//
//  User.swift
//  Instagram
//
//  Created by lhduc on 13/10/2022.
//
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let avatarUrl: String
    var hasStory: Bool = false
}
