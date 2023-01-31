//
//  MockData.swift
//  Instagram
//
//  Created by lhduc on 13/10/2022.
//

import Foundation

struct MockData {
    static let users: [User] = [
        User(id: "XTzUZUn51MWFEShk3R3nIoe5R4s2", email: "user1@gmail.com", username: "user1.instagram", fullName: "User1", avatarUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramdb-70607.appspot.com/o/XTzUZUn51MWFEShk3R3nIoe5R4s2?alt=media&token=56758ab2-22bb-4742-bfd3-2abb8b10d504"),
        User(id: "user2", email: "user2@gmail.com", username: "user2.das", fullName: "User2", avatarUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramdb-70607.appspot.com/o/profile_avatar%2FZI45HNIJvcdjbfL1ljtw9DCEMDt2?alt=media&token=c5ad5ecd-edcb-491c-83bf-4b4a835e8fbd", hasStory: true),
        User(id: "user3", email: "user3@gmail.com", username: "user3.9c", fullName: "User3", avatarUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramdb-70607.appspot.com/o/a5RRaJzAJJSe6W14xB6oH03uoY62?alt=media&token=1280f918-1476-4053-a52f-7dbcf5046a1c"),
    ]
    
    static let posts: [Post] = [
        Post(id: "1", uid: "1",
             caption: "I don’t know what my future holds, but I’m hoping you are in it",
             imagesUrl: ["https://firebasestorage.googleapis.com:443/v0/b/instagramdb-70607.appspot.com/o/posts%2FD5271E37-B7D7-45A6-96B0-6AA26274452F?alt=media&token=25c238d7-50a0-4dec-819a-932bce6c4cbb"],
             categories: ["IGTV", "Shop"],
             likes: ["user1", "user2"] ,
             user: users[0]
            ),
        Post(id: "2", uid: "2",
             caption: "It only takes a second to say I love you, but it will take a lifetime to show you how much",
             imagesUrl: ["https://firebasestorage.googleapis.com:443/v0/b/instagramdb-70607.appspot.com/o/posts%2FE1FD9215-C148-4B66-B8EF-41FEC0D6A116?alt=media&token=6c1a2308-abf6-4042-8771-8fd037b4a22b"],
             categories: ["Sport", "Style", "Shop"],
             likes: ["user1"],
             user: users[1]
            ),
        Post(id: "3", uid: "3",
             caption: "You light up my life",
             imagesUrl: ["https://firebasestorage.googleapis.com:443/v0/b/instagramdb-70607.appspot.com/o/posts%2FFA1B0BA7-6D5F-4275-8CD4-B7DD5BEB22C1?alt=media&token=5c9d0b21-855f-4787-8c56-4d5e2a5c63f9"],
             categories: [],
             commentCount: 3,
             user: users[2]
            ),
    ]
    
    static let notifications: [Notification] = [
        Notification(uid: "7D49028F-46DB-4D0E-8579-FDD74DE4B10D", action: .comment, type: .post, referenceId: "rPWRHypiUUMYUB0WDIh6", userInteractionId: "rPWRHypiUUMYUB0WDIh6", content: "has commented on your post")
    ]
    
    static let conversations: [Conversation] = [
//        Conversation(id: "1", uid1: users[0].id!, uid2: users[1].id!, user1: users[0], user2: users[1], messages: [
//            Message(id: "1", senderId: users[0].id!, text: "Hello \(users[1].fullName)"),
//            Message(id: "2", senderId: users[1].id!, text: "Hello Duc"),
//        ]),
//        Conversation(id: "2", uid1: users[2].id!, uid2: users[0].id!, user1: users[2], user2: users[0], messages: [
//            Message(id: "1", senderId: users[0].id!, text: "Hello \(users[2].fullName)"),
//            Message(id: "2", senderId: users[2].id!, text: "Hello Duc"),
//            Message(id: "1", senderId: users[0].id!, text: "Nice to meet you"),
//        ])
        Conversation(id: "1", participants: [users[0], users[1]], messages: [
            Message(id: "1", senderId: users[0].id!, text: "Hello \(users[1].fullName)"),
            Message(id: "2", senderId: users[1].id!, text: "Hello Duc"),
        ]),
        Conversation(id: "2", participants: [users[2], users[1]], messages: [
            Message(id: "1", senderId: users[0].id!, text: "Hello \(users[2].fullName)"),
            Message(id: "2", senderId: users[2].id!, text: "Hello Duc"),
            Message(id: "1", senderId: users[0].id!, text: "Nice to meet you"),
        ])
    ]
    
    static let messages: [Message] = [
        Message(id: "1", senderId: users[0].id!, text: "Hello Duc"),
        Message(id: "2", senderId: users[1].id!, text: "Abcdem"),
    ]
}
