//
//  ActivityModel.swift
//  Instagram
//
//  Created by Tran Thuan on 17/10/2022.
//

import Foundation

enum ActivityType {
    case liked
    case newFollower
    case suggestFollower
    case comment
}

struct Activity: Identifiable {
    let id = UUID()
    let activity: ActivityType
    let duration: String //Easier to show on UI.
    let usersInContext: [User]
    let post: Post
    var comment: String = ""

    func getUsernames() -> String {
        return usersInContext.map{$0.userName}.joined(separator: ", ")
    }
}

