//
//  CommentRowView.swift
//  Instagram
//
//  Created by lhduc on 14/11/2022.
//

import SwiftUI

struct CommentRow: View {
    let comment: Comment
    
    var body: some View {
        HStack(alignment: .top){
            CircleAvatar(imageUrl: comment.user!.avatarUrl, radius: 35)
            VStack(alignment: .leading) {
                Group {
                    Text("\(comment.user!.username) ").font(.system(.subheadline)).bold() +
                    Text(comment.comment).font(.system(.subheadline)).fontWeight(.light)
                }
                
                Text(comment.getTimeCommentAgo())
                    .font(.system(.caption))
                    .foregroundColor(Color.semiText)
            }
            Spacer()
            IconButton(imageIcon: Image.icnHeart, size: 15) {}
        }
    }
}

struct CommentRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommentRow(comment: Comment(uid: MockData.users[0].id!, comment: "Hi yo!"))
    }
}
