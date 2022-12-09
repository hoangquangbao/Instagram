//
//  UserRowImageOptions.swift
//  Instagram
//
//  Created by lhduc on 09/12/2022.
//

import SwiftUI

struct UserRowImageOptions {
    let systemName: String
    var imageSize: CGFloat = 18
    var spacing: CGFloat = 5
    var foregroundColor: Color = Color.white
    var backgroundColor: Color = Color.green
    var alignment: Alignment = .bottomTrailing
    
    var circleSize: CGFloat {
        return imageSize + spacing
    }
}
