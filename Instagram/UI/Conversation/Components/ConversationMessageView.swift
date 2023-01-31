//
//  ConversationMessageView.swift
//  Instagram
//
//  Created by lhduc on 11/01/2023.
//

import SwiftUI

struct ConversationMessageView: View {
    let messages: [Message]
    private let columns = [GridItem(.flexible(minimum: 10))]
    
    @EnvironmentObject var sessionVm: SessionViewModel
    @EnvironmentObject var vm: ConversationViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                if vm.isMessagesLoading {
                    ProgressView()
                } else {
                    ForEach(messages) { message in
                        let isReceive = message.senderId != sessionVm.uid
                        
                        BubbleMessageView(message: message, isReceive: isReceive)
                    }
                }
            }
            .padding(.horizontal, AppStyle.defaultSpacing)
        }
    }
}

struct ConversationMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationMessageView(messages: MockData.messages)
            .environmentObject(SessionViewModel())
    }
}
