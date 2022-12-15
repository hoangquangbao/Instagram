//
//  DefaultShimmering.swift
//  Instagram
//
//  Created by lhduc on 13/12/2022.
//

import SwiftUI
import Shimmer

enum ShimmerShapeType { case rectangle, circle }

struct DefaultShimmering: ViewModifier {
    var shape: ShimmerShapeType = .rectangle
    
    func body(content: Content) -> some View {
        if shape == .circle {
            content
                .shimmering()
                .background(Color.gray)
                .foregroundColor(Color.white)
                .clipShape(Circle())
        } else {
            content
                .shimmering()
                .background(Color.gray)
                .foregroundColor(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 3))
        }
    }
}
