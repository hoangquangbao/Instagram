//
//  StoryAvatarShimmer.swift
//  Instagram
//
//  Created by lhduc on 04/11/2022.
//

import SwiftUI
import Shimmer

struct StoryAvatarShimmer: View {
    var body: some View {
        VStack {
            Circle().frame(width: 60, height: 60).shimmering()
            Rectangle()
                .frame(width: 60, height: 8)
                .padding(.top, 2)
                .shimmering()
        }
        .padding(.top, 8)
    }
}

struct StoryAvatarShimmer_Previews: PreviewProvider {
    static var previews: some View {
        StoryAvatarShimmer()
    }
}
