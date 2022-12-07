//
//  TimestampHelper.swift
//  Instagram
//
//  Created by lhduc on 07/12/2022.
//

import Firebase

class TimestampHelper {
    static func getTimeAgo(timestamp: Timestamp) -> String {
        return timestamp.dateValue().timeAgoDisplay()
    }
}
