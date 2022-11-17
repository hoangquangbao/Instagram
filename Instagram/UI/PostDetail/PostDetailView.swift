//
//  PostDetailView.swift
//  Instagram
//
//  Created by lhduc on 17/11/2022.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    
    var body: some View {
        ScrollView {
            PostRow(post: post)
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: MockData.posts[0])
    }
}
