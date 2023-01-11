//
//  ListTileView.swift
//  Instagram
//
//  Created by lhduc on 11/01/2023.
//

import SwiftUI

struct ListTileView: View {
    let imageUrl: String
    let title: String
    let subTitle: String?
    
    var imageSize: CGFloat = 35
    
    var body: some View {
        HStack(spacing: 10) {
            CircleAvatar(imageUrl: imageUrl, radius: imageSize)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(title).font(.headline).lineLimit(1)
                if let subTitle = subTitle {
                    Text(subTitle)
                        .font(.caption)
                        .lineLimit(1)
                        .foregroundColor(Color.semiText)
                }
            }
        }
    }
}

struct ListTileView_Previews: PreviewProvider {
    static var previews: some View {
        ListTileView(imageUrl: MockData.users[0].avatarUrl, title: MockData.users[0].fullName, subTitle: MockData.users[0].username)
    }
}
