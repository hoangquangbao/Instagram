//
//  ImageGridShimmer.swift
//  Instagram
//
//  Created by lhduc on 09/12/2022.
//

import SwiftUI
import Shimmer

struct ImageGridShimmer: View {
    private let _spacing = 2.0
    private var _gridColumns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    private let size = UIScreen.screenWidth / 3
    
    var body: some View {
        LazyVGrid(columns: _gridColumns, spacing: _spacing) {
            ForEach(0..<3, id: \.self) { _ in
                Rectangle().frame(width: size, height: size).shimmering()
            }
        }
    }
}

struct ImageGridShimmer_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridShimmer()
    }
}
