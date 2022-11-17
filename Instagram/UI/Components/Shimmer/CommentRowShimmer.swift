//
//  CommentRowShimmer.swift
//  Instagram
//
//  Created by lhduc on 14/11/2022.
//

import SwiftUI
import Shimmer

struct CommentRowShimmer: View {
    var body: some View {
        HStack {
            UserRowShimmer().circleAvatar(radius: 50)
            VStack(alignment: .leading) {
                Rectangle().frame(width: 70, height: 10).shimmering()
                GeometryReader { proxy in
                    Rectangle().frame(width: proxy.size.width, height: 10).shimmering()
                }
                
                GeometryReader { proxy in
                    Rectangle().frame(width: proxy.size.width, height: 10).shimmering()
                }
            }
        }
    }
}

struct CommentRowShimmer_Previews: PreviewProvider {
    static var previews: some View {
        CommentRowShimmer()
    }
}
