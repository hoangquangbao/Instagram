//
//  PostDetailView.swift
//  Instagram
//
//  Created by lhduc on 17/11/2022.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post?
    
    var body: some View {
        if let post = post {
            ScrollView {
                PostRow(post: post)
            }
        } else {
            VStack {
                Text("This post does not exist")
                Text("or has been deleted by author.")
            }
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: MockData.posts[0])
    }
}
