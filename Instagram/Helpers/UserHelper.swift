//
//  UserHelper.swift
//  Instagram
//
//  Created by lhduc on 08/12/2022.
//

import Foundation

struct UserHelper {
    /// Returns the latest mention by username from String input.
    ///
    ///     let string = "Hi @lhduc and @lhduc2205"
    ///     print(getLastMentionUsername(from: string))
    ///     // Prints "lhduc2205"
    ///
    static func getLastMentionUsername(from string: String) -> String {
        let separatorSplit = string.split(separator: "@")
        let userSearchableText = String(separatorSplit[separatorSplit.count - 1])
        
        return userSearchableText
    }
    
    
    /// Returns the String after replacing latest username.
    ///
    ///     let username = "lhduc2205"
    ///     let string = "Hi, @lhduc and @l"
    ///
    ///     print(replaceLatestMentionUser(from: string, by: username))
    ///     // Prints "Hi, @lhduc and @lhduc2205"
    ///
    static func replaceLatestMentionUser(from string: String, by username: String) -> String {
        let lastSeparatorIndex = string.lastIndex(of: "@") ?? string.endIndex
        var subString = string[..<lastSeparatorIndex]
        subString += "@\(username)"
        
        return String(subString)
    }
    
    /// Returns sequences of the correct username collection
    ///
    ///     let users = [
    ///         User(username: "lhduc"),
    ///         User(username: "lhduc2205"),
    ///     ]
    ///     let string = "Hi, @lhduc @wrongUsername and @lhduc2205"
    ///
    ///     print(getAllMentionUser(from: string, with: users))
    ///     // Prints ["lhduc", "lhduc2205"]
    ///
    static func getAllMentionUser(from string: String, with users: [User]) -> [User] {
        let separatorSplit = string.split(separator: " ")
        var mentionUsers: [User] = []

        separatorSplit.forEach { element in
            if !element.hasPrefix("@") { return }
            
            var username = element
            username.remove(at: username.startIndex)
            
            let user = users.first(where: {$0.username == username} )
            if user == nil { return }
            
            mentionUsers.append(user!)
        }
        
        return mentionUsers
    }
}
