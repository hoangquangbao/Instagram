//
//  PostRowShimmer.swift
//  Instagram
//
//  Created by lhduc on 04/11/2022.
//

import SwiftUI
import Shimmer

struct PostRowShimmer: View {
    var body: some View {
        VStack(alignment: .leading) {
            UserRowShimmer()
                .padding(.horizontal, AppStyle.defaultSpacing)
            
            postImage
            
            actionButtons
            
            caption
            
            comment
                        
        }
        .padding(.top, 15)
    }
}

extension PostRowShimmer {
    var postImage: some View {
            RectangleShimmer(width: UIScreen.screenWidth, height: UIScreen.screenWidth)
            .padding(.top, 8)
    }
    
    var actionButtons: some View {
        HStack(spacing: 12) {
//            RectangleShimmer(width: 25, height: 25)
            Image.icnHeart.shimmering()
            Image.icnComment.shimmering()
            Image.icnShare.shimmering()
            Spacer()
            Image.icnBookmark.shimmering()
        }
        .padding(.top, 9)
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
    
    var caption: some View {
        GeometryReader { proxy in
            RectangleShimmer(width: proxy.size.width, height: 10)
                .padding(.top, 8)
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
    
    var comment: some View {
        HStack {
            UserRowShimmer().circleAvatar(radius: 30)
            Text("Add comment")
                .font(.footnote)
                .foregroundColor(Color.semiText)
                .shimmering()
        }
        .padding(.top)
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
}

struct RectangleShimmer: View {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Rectangle()
            .frame(width: width, height: height)
            .shimmering()
    }
}

struct PostRowShimmer_Previews: PreviewProvider {
    static var previews: some View {
        PostRowShimmer()
    }
}
