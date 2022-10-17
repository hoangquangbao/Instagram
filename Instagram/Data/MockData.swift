//
//  MockData.swift
//  Instagram
//
//  Created by lhduc on 13/10/2022.
//

import Foundation

struct MockData {
    static let users: [User] = [
        User(id: "user1", username: "user1.instagram", fullname: "User1", avatarUrl: "img_profile"),
        User(id: "user2", username: "user2.das", fullname: "User2", avatarUrl: "img_profile2", hasStory: true),
        User(id: "user3", username: "user3.9c", fullname: "User3", avatarUrl: "img_profile3"),
        User(id: "user4", username: "user4.gmail", fullname: "User4", avatarUrl: "img_profile4", hasStory: true),
        User(id: "user5", username: "user5.asd", fullname: "User5", avatarUrl: "img_profile5"),
    ]
    
    static let posts: [Post] = [
        Post(id: "1", uid: "1",
             caption: "I don’t know what my future holds, but I’m hoping you are in it",
             imagesUrl: ["img_profile", "img_profile2"],
             categories: ["IGTV", "Shop"],
             likes: [users[1], users[2]] ,
             user: users[0]
        ),
        Post(id: "2", uid: "2",
             caption: "It only takes a second to say I love you, but it will take a lifetime to show you how much",
             imagesUrl: ["img_profile2", "img_profile3", "img_profile4"],
             categories: ["Sport", "Style", "Shop"],
             likes: [users[0]],
             user: users[1]
        ),
        Post(id: "3", uid: "3",
             caption: "You light up my life",
             imagesUrl: ["img_profile5"],
             categories: [],
             comments: [users[0], users[1], users[2]],
             user: users[2]
        ),
    ]
}
