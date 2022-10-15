//
//  ExploreView.swift
//  Instagram
//
//  Created by lhduc on 14/10/2022.
//

import SwiftUI

struct ExploreView: View {
    let post: Post
    
    private let posts: [Post] = MockData.posts
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
            ScrollView {
                LazyVStack {
                    PostRow(post: post).padding(.bottom, 0.5)
                    ForEach(posts) { _post in
                        if(!(_post == post)) {
                            PostRow(post: _post).padding(.bottom, 0.5)
                        }
                    }
                }
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(post: MockData.posts[0])
    }
}
