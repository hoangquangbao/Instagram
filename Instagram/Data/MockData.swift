//
//  MockData.swift
//  Instagram
//
//  Created by lhduc on 13/10/2022.
//

import Foundation

struct MockData {
    static let users: [User] = [
        User(id: "user1", username: "user1@instagram", fullname: "User1", avatarUrl: "img_profile"),
        User(id: "user2", username: "user2.das", fullname: "User2", avatarUrl: "img_profile2", hasStory: true),
        User(id: "user3", username: "user3.9c", fullname: "User3", avatarUrl: "img_profile3"),
        User(id: "user4", username: "user4@gmail", fullname: "User4", avatarUrl: "img_profile4", hasStory: true),
        User(id: "user5", username: "user5@asd", fullname: "User5", avatarUrl: "img_profile5"),
    ]
}
