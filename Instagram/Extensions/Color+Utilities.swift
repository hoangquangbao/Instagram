//
//  Color+Utilities.swift
//  Instagram
//
//  Created by lhduc on 05/10/2022.
//

import SwiftUI

extension Color {
    init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, withOpacity opacity: CGFloat?) {
        self.init(red: red/255.0, green: green/255.0, blue: blue/255, opacity: opacity ?? 0)
    }
}
