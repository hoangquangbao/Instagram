//
//  ExploreView.swift
//  Instagram
//
//  Created by lhduc on 14/10/2022.
//

import SwiftUI

struct ExploreView: View {
    let id: String
    let posts: [Post]
    @EnvironmentObject var postVm: PostViewModel
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                LazyVStack {
                    ForEach(posts) { _post in
                        PostRow(post: _post).padding(.bottom, 0.5)
                            .id(_post.id)
                    }
                }
                .onAppear(perform: {
                    proxy.scrollTo(id, anchor: .top)
                })
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(id: MockData.posts[0].id!, posts: MockData.posts)
    }
}
