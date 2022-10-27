//
//  ImageTabIndicator.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//

import SwiftUI

struct ImageTabIndicator: View {
    let tabCount: Int
    @Binding var activeIndex: Int
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<tabCount, id: \.self) { index in
                if index == activeIndex {
                    _DotCustomized(color: Color._3897F0)
                } else {
                    _DotCustomized(color: Color.appPrimary.opacity(0.15))
                }
            }
        }
    }
}

private struct _DotCustomized: View {
    let color: Color
    let size: CGFloat = 7
    
    var body: some View {
        Rectangle()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .foregroundColor(color)
    }
}

struct ImageTabIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ImageTabIndicator(tabCount: 3, activeIndex: .constant(0))
    }
}
