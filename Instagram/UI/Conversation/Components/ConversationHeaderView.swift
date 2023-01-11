//
//  ConversationHeaderView.swift
//  Instagram
//
//  Created by lhduc on 11/01/2023.
//

import SwiftUI

struct ConversationHeaderView: View {
    let participant: User
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack(spacing: 15) {
            IconButton(imageIcon: Image.icnBack) {
                presentationMode.wrappedValue.dismiss()
            }
            
            ListTileView(imageUrl: participant.avatarUrl, title: participant.fullName, subTitle: participant.username)
            
            Spacer()
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
}

struct ConversationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationHeaderView(participant: MockData.users[0])
    }
}
