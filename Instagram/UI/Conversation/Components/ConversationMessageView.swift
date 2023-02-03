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
            ScrollViewReader { scrollReader in
                messageView
                    .onChange(of: messages.count) { _ in
                        if let messageId = messages.last?.id {
                            scrollTo(messageId: messageId, shouldAnimate: true, scrollReader: scrollReader)
                        }
                    }
                    .onAppear {
                        if let messageId = messages.last?.id {
                            scrollTo(messageId: messageId, anchor: .bottom, shouldAnimate: false, scrollReader: scrollReader)
                        }
                    }
            }
        }
    }
}


private extension ConversationMessageView {
    var messageView: some View {
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

private extension ConversationMessageView {
    func scrollTo(messageId: String, anchor: UnitPoint? = nil, shouldAnimate: Bool, scrollReader: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? Animation.easeIn : nil) {
                scrollReader.scrollTo(messageId, anchor: anchor)
            }
        }
    }
}

struct ConversationMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationMessageView(messages: MockData.messages)
            .environmentObject(SessionViewModel())
    }
}
