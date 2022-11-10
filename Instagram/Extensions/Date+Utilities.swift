//
//  Date+Utilities.swift
//  Instagram
//
//  Created by lhduc on 14/10/2022.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.locale = Locale(identifier: "en_US")
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
