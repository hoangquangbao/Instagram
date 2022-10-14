//
//  AppStyle.swift
//  Instagram
//
//  Created by lhduc on 05/10/2022.
//
import SwiftUI

struct AppStyle {
    static let defaultSpacing: CGFloat = 10
    static let defaultAvatarSize: CGFloat = 60
    
    static let storyLinearGradient: LinearGradient = LinearGradient(
        colors: [.red, .purple, .red, .orange, .yellow, .orange],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    
}
