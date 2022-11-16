//
//  ExploreView.swift
//  Instagram
//
//  Created by lhduc on 14/10/2022.
//

import SwiftUI

struct ExploreView: View {
    let post: Post
    @EnvironmentObject var postVm: PostViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    PostRow(post: post).padding(.bottom, 0.5)
                    ForEach(postVm.getNotOwningPost()) { _post in
                        if(_post.id != post.id) {
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
